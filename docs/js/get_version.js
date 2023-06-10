function getServerVersion() {
  return new Promise(function(resolve, reject) {
    // 发起请求获取服务器上资源的版本号
    // 这里使用 XMLHttpRequest 作为示例，你也可以使用 fetch 方法
    var xhr = new XMLHttpRequest();
    xhr.open('GET', '/version.txt'); // 替换为实际资源版本号文件的路径
    xhr.onload = function() {
      if (xhr.status === 200) {
        resolve(xhr.responseText.trim()); // 返回服务器上的版本号
      } else {
        reject(new Error('Failed to fetch server version.'));
      }
    };
    xhr.onerror = function() {
      reject(new Error('Failed to fetch server version.'));
    };
    xhr.send();
  });
}
