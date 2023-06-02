class WebhookSender {
    var url:String = "";
    public function new(url:String) {
        this.url = url;
    }
    public function send(data:Dynamic) {
        var http:haxe.Http = new haxe.Http(url);
        http.setPostData(haxe.Json.stringify(data));
        http.addHeader("Content-Type", "application/json");
        http.request(true);
    }
}