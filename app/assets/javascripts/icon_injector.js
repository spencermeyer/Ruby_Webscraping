$(document).ready(function(){
  if(window.location.host.indexOf('localhost') > -1) { 
    master = window.parent.document;
    head = master.getElementsByTagName("head")[0];
    favicon = master.createElement("link");
    favicon.rel = "shortcut icon";
    favicon.type = "image/png";
    favicon.href = "/runner_icon2.png";
    head.appendChild(favicon);
  }
});