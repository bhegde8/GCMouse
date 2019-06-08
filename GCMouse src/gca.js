var usb = require('usb');

var ENDPOINT_IN = 0x81;
var ENDPOINT_OUT = 0x02;

function getAdaptersList() {
    usbList = usb.getDeviceList();
    list = []
    for (var i=0;i<usbList.length;i++) {
        if(usbList[i].deviceDescriptor.idVendor === 1406 && usbList[i].deviceDescriptor.idProduct === 823)
            list.push(usbList[i]);
    }
    return list;
}

function startAdapter(adapter) {
    adapter.open();
    var iface = adapter.interface(0);
    try {
        if (iface.isKernelDriverActive()) {
            iface.detachKernelDriver();
            console.log("Kernel driver has been detached.");
        }
    } catch(e) {
        if(e.errno === -12)
            console.warn("Checking for kernel driver status is not supported in this platform. Kernel will not be detached.");
        else
            console.error(e);
    } finally {
        iface.claim();
        var endpoint = iface.endpoint(ENDPOINT_OUT);
        var code = endpoint.transfer([0x13],function(e) {
            if(e)
                console.error(e);
            return e;
        })
        return code;
    }
}

function readData(adapter,callback) {
    var iface = adapter.interface(0);
    var endpoint = iface.endpoint(ENDPOINT_IN);
    endpoint.transfer(37,function (e,data){
        if(e) {
            console.error(e);
            return;
        } else {
            callback(data);
        }
        return;
    })
}

function pollData(adapter,callback) {
    var iface = adapter.interface(0);
    var endpoint = iface.endpoint(ENDPOINT_IN);
    endpoint.startPoll(1,37);
    endpoint.on('data',function (data){
        callback(data);
        return;
    })
}

function rawData(data) {
    var arr = [];
    var results = data.slice(1);
    for(var i=0;i<36;i++) {
        arr[i]='';
        for(var j=0;j<8;j++) {
            arr[i] += (results[i]>>j) & 1;
        }
    }
    return arr;
}

function objectData(data) {
    var arr = rawData(data);
    var status = [];
    for(var port=0;port<4;port++) {
        status[port] = {
            'port': port+1,
            'connected': 1 == arr[0+9*port][4],
            'buttons': {
                'StartButton': 1 == arr[2+9*port][0],
                'ZButton': 1 == arr[2+9*port][1],
                'AButton': 1 == arr[1+9*port][0],
                'BButton': 1 == arr[1+9*port][1],
                'XButton': 1 == arr[1+9*port][2],
                'YButton': 1 == arr[1+9*port][3],
                'DPUPButton': 1 ==  arr[1+9*port][7],
                'DPDOWNButton': 1 == arr[1+9*port][6],
                'DPLEFTButton': 1 == arr[1+9*port][4],
                'DPRIGHTButton': 1 == arr[1+9*port][5],
                'LTrigger': 1 == arr[2+9*port][3],
                'RTrigger': 1 == arr[2+9*port][2]
            },
            'axes': {
                'MAINSTICKHorizontal': (data[4+9*port]/128)-1,
                'MAINSTICKVertical': (data[5+9*port]/128)-1,
                'CSTICKHorizontal': (data[6+9*port]/128)-1,
                'CSTICKVertical': (data[7+9*port]/128)-1,
                'LAnalog': (data[8+9*port]/128)-1,
                'RAnalog': (data[9+9*port]/128)-1
            },
            'rumble': false
        }
    }

    return status;
}

function checkRumble(adapter,controllers) {
    var iface = adapter.interface(0);
    var endpoint = iface.endpoint(ENDPOINT_OUT);
    var data = [0x11];

    for(var port=0;port<4;port++) {
        data[port+1] = controllers[port].rumble;
    }

    endpoint.transfer(data,function(e) {
        if(e) {
            console.error(e);
        }
        return;
    })
}

function stopAdapter(adapter) {
    var iface = adapter.interface(0);
    var endpoint = iface.endpoint(ENDPOINT_OUT);
    
    endpoint.transfer([0x14],function(e) {
       if(e) {
          console.error(e);
       } else {
          iface.release([ENDPOINT_IN,ENDPOINT_OUT],function(e) {
              if(e) console.error(e);
          });
          adapter.close();
       }
       return;
    })
}

module.exports = {readData,pollData,startAdapter,getAdaptersList,rawData,objectData,checkRumble,stopAdapter};