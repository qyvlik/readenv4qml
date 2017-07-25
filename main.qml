import QtQuick 2.6

Item {
    width: 240
    height: 320

    function setHeader(xhr, headers) {
        //"Content-Type":"application/x-www-form-urlencoded"
        for(var iter in headers) {
            xhr.setRequestHeader(iter, headers[iter]);
        }
    }

    function ajax(method, url, headers, data, callable) {
        headers = headers || {};
        callable = callable || function(xhr) {
            console.log(xhr.responseText);
        }
        var xhr = new XMLHttpRequest;
        xhr.onreadystatechange = function() {
            if (xhr.readyState === xhr.DONE) {
                callable(xhr);
            }
        };
        xhr.open(method, url);
        setHeader(xhr, headers);
        if("GET" === method) {
            xhr.send();
        } else {
            xhr.send(data);
        }
    }

    function readFileAsync(file, callable, error) {
        callable = callable || function(fileContent) {
            console.log("content length:", fileContent.length);
        }
        error = error || function(e) {
            console.log("readFileAsync error : ", e);
        }
        ajax("GET", file, {}, "", function(xhr){
            if(xhr.status !== 200) {
                error("file "+file + " not exist!");
            } else {
                callable(xhr.responseText);
            }
        });
    }


    Column {
        anchors.fill: parent

        Rectangle {
            width: parent.width
            height: 60
            Text {
                anchors.centerIn: parent
                text: "call shell"
                color: "red"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    var result = Qt.openUrlExternally(Qt.resolvedUrl("./echo_path_to_file.bat"));
                    console.log("call shell success:", result);
                }
            }
        }

        Rectangle {
            width: parent.width
            height: 60
            Text {
                anchors.centerIn: parent
                text: "read path"
                color: "blue"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    readFileAsync(Qt.resolvedUrl("path.txt"), function(content){
                        console.log('PATH:', content);
                    });
                }
            }
        }
    }
}
