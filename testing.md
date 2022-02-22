Sourceprocessor.perform

LineProcessor.perform({'args_hash': { slink: "http://www.parkrun.org.uk/southampton/results/weeklyresults/?runSeqNumber=429", browser: Mechanize::AGENT_ALIASES.to_a.reject{|entry| entry[0]=='Mechanize' }.sample[0] } }.deep_stringify_keys )


["southampton/results/weeklyresults/?runSeqNumber=429", "whiteley/results/weeklyresults/?runSeqNumber=173", "eastleigh/results/weeklyresults/?runSeqNumber=526", "horsham/results/weeklyresults/?runSeqNumber=323", "bartleypark/results/weeklyresults/?runSeqNumber=10", "greatsalterns/results/weeklyresults/?runSeqNumber=5"]

["https://www.parkrun.org.uk/southampton/results/weeklyresults/?runSeqNumber=429",
 "https://www.parkrun.org.uk/whiteley/results/weeklyresults/?runSeqNumber=173",
 "https://www.parkrun.org.uk/eastleigh/results/weeklyresults/?runSeqNumber=526",
 "https://www.parkrun.org.uk/horsham/results/weeklyresults/?runSeqNumber=323",
 "https://www.parkrun.org.uk/bartleypark/results/weeklyresults/?runSeqNumber=10",
 "https://www.parkrun.org.uk/greatsalterns/results/weeklyresults/?runSeqNumber=5"]



Problems:
---------

using nil as an age category and assigning position in this.

https://stackoverflow.com/questions/4622739/how-to-get-mechanize-requests-to-look-like-they-originate-from-a-real-browser


  "rack.errors"=>#<IO:<STDERR>>,
     "rack.multithread"=>true,
     "rack.multiprocess"=>false,
     "rack.run_once"=>false,
     "SCRIPT_NAME"=>"",
     "QUERY_STRING"=>"",
     "SERVER_PROTOCOL"=>"HTTP/1.1",
     "SERVER_SOFTWARE"=>"puma 3.12.2 Llamas in Pajamas",
     "GATEWAY_INTERFACE"=>"CGI/1.2",
     "REQUEST_METHOD"=>"GET",
     "REQUEST_PATH"=>"/",
     "REQUEST_URI"=>"/",
     "HTTP_VERSION"=>"HTTP/1.1",
     "HTTP_ACCEPT_ENCODING"=>"gzip,deflate,identity",
     "HTTP_ACCEPT"=>"*/*",
     "HTTP_USER_AGENT"=>
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2486.0 Safari/537.36 Edge/13.10586",
     "HTTP_ACCEPT_CHARSET"=>"ISO-8859-1,utf-8;q=0.7,*;q=0.7",
     "HTTP_ACCEPT_LANGUAGE"=>"en-us,en;q=0.5",
     "HTTP_HOST"=>"localhost:3000",
     "HTTP_CONNECTION"=>"keep-alive",
     "HTTP_KEEP_ALIVE"=>"300",
     "SERVER_NAME"=>"localhost",
     "SERVER_PORT"=>"3000",
     "PATH_INFO"=>"/",
     "REMOTE_ADDR"=>"127.0.0.1",
     "puma.socket"=>#<TCPSocket:fd 22>,
     "rack.hijack?"=>true,
     "rack.hijack"=>#<Puma::Client:0x2ac65645e4c0 @ready=true>,
     "rack.input"=>#<Puma::NullIO:0x00558cac93e200>,
     "rack.url_scheme"=>"http",
     "rack.after_reply"=>[],


Comparing Mechanise with Chrome on http://browserspy.dk/browser.php  maybe also spoof:

info os.name
info browser.name
info browser.version
operating system


Mechanize::AGENT_ALIASES.to_a.sample

