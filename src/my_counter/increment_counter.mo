import Text "mo:base/Text";
import Nat "mo:base/Nat";
// Create a simple Counter actor.
actor Counter {
  stable var currentValue : Nat = 0;

  // Increment the counter with the increment function.
  public func increment() : async () {
    currentValue += 1;
  };

  // Read the counter value with a get function.
  public query func get() : async Nat {
    currentValue
  };

  // Write an arbitrary value with a set function.
  public func set(n: Nat) : async () {
    currentValue := n;
  };
  public type HeaderField = (Text,Text) ;

    public type HttpRequest ={
    method: Text;
    url: Text;
    body: [Nat8];
    headers: [HeaderField] ;
    };

    public type HttpResponse={
    body: Blob;
    headers: [HeaderField] ;
    streaming_strategy: ?StreamingStrategy;
    status_code: Nat16;
    };
    
    public type Key=Text;
    public type Path=Text;
    public type ChunkID = Nat;
    public type StreamingContentArgument  = {
    key : Key;
    content_encoding : Text; 
    Chunk_ids : [ChunkID]; //starts at 1
    sha256: ?[Nat8];
    };
    public type StreamingCallbackToken = {
    key : Text;
    content_encoding : Text;
    index : Nat; //starts at 1
    sha256: ?[Nat8];
  };
  

  public type StreamingCallbackHttpResponse = {
    token : ?StreamingCallbackToken;
    body : Blob;
  };

  public type StreamingCallback = query StreamingCallbackToken  -> async StreamingCallbackHttpResponse;


  public type StreamingStrategy = {
    #Callback: {
      token : StreamingCallbackToken;
      callback : StreamingCallback
    }
  };


    public shared query func http_request(request: HttpRequest) : async HttpResponse {
        {
            body =Text.encodeUtf8("<html><body><h1>Count: "#Nat.toText(currentValue)#"</h1></body></html>");
            headers=[];
            streaming_strategy=null;
            status_code=200;
        }

      
    };


}

