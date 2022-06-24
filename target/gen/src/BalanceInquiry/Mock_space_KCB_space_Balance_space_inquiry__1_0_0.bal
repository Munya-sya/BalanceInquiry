import ballerina/http;
import ballerina/time;
import ballerina/runtime;

import wso2/gateway;


    
http:Client Mock_space_KCB_space_Balance_space_inquiry__1_0_0_prod = new (
gateway:retrieveConfig("prodEndPoint_prod_endpoint_0","http://192.168.1.103:8080"),
{ 
httpVersion: gateway:getClientsHttpVersion()
, responseLimits : {
         maxStatusLineLength : gateway:getConfigIntValue(gateway:HTTP_CLIENTS_RESPONSE_LIMITS_CONFIG_INSTANCE_ID,
                    gateway:HTTP_CLIENTS_RESPONSE_MAX_STATUS_LINE_LENGTH, gateway:DEFAULT_HTTP_CLIENTS_RESPONSE_MAX_STATUS_LINE_LENGTH),
         maxHeaderSize : gateway:getConfigIntValue(gateway:HTTP_CLIENTS_RESPONSE_LIMITS_CONFIG_INSTANCE_ID,
                    gateway:HTTP_CLIENTS_RESPONSE_MAX_HEADER_SIZE, gateway:DEFAULT_HTTP_CLIENTS_RESPONSE_MAX_HEADER_SIZE),
         maxEntityBodySize: gateway:getConfigIntValue(gateway:HTTP_CLIENTS_RESPONSE_LIMITS_CONFIG_INSTANCE_ID,
                    gateway:HTTP_CLIENTS_RESPONSE_MAX_ENTITY_BODY_SIZE, gateway:DEFAULT_HTTP_CLIENTS_RESPONSE_MAX_ENTITY_BODY_SIZE)
  }
,
    cache: { enabled: false }


,
secureSocket: gateway:getClientSecureSocket()

,
    poolConfig: gateway:getClientPoolConfig(true, 0, -1, -1, -1)


, http1Settings : {
    proxy: gateway:getClientProxyConfig()
}


});









    
    
    
    
    
    

    
    

    
    



//This variable is added for logging purposes
string Mock_space_KCB_space_Balance_space_inquiry__1_0_0Key = "Mock KCB Balance inquiry-1.0.0";









@http:ServiceConfig {
    basePath: "/MockBalanceInquiry/1.0.0",
    auth: {
        authHandlers: gateway:getAuthHandlers(["oauth2","jwt"], false, false)
    }
   ,
    cors: {
         allowOrigins: ["*"],
         allowCredentials: true,
         allowHeaders: ["authorization","Access-Control-Allow-Origin","Content-Type","SOAPAction","apikey","Internal-Key"],
         allowMethods: ["GET","PUT","POST","DELETE","PATCH","OPTIONS"],
         exposeHeaders: []
    }
    
}

@gateway:API {
    publisher:"",
    name:"Mock KCB Balance inquiry",
    apiVersion: "1.0.0",
    apiTier : "" ,
    authProviders: ["oauth2","jwt"],
    security: {
            "apikey":[],
            "mutualSSL": "",
            "applicationSecurityOptional": false
        }
}
service Mock_space_KCB_space_Balance_space_inquiry__1_0_0 on apiListener,
apiSecureListener {


    @http:ResourceConfig {
        methods:["POST"],
        path:"/api/balance/services",
        auth:{
        
            enabled:false,
        
            authHandlers: gateway:getAuthHandlers(["oauth2","jwt","basic"], false, false)
        }
    }
    @gateway:Resource {
        authProviders: ["oauth2","jwt","basic"],
        security: {
            "apikey":[],
            "applicationSecurityOptional": false 
            }
    }
    @gateway:RateLimit{policy : "Unlimited"}
    resource function post45338f7bde9c4712b38bbe0e40718615 (http:Caller outboundEp, http:Request req
) {
        handleExpectHeaderForMock_space_KCB_space_Balance_space_inquiry__1_0_0(outboundEp, req);
        runtime:InvocationContext invocationContext = runtime:getInvocationContext();

        map<string> pathParams = { 
        };
        invocationContext.attributes["pathParams"] = pathParams;
        

        
        string urlPostfix = gateway:replaceFirst(req.rawPath,"/MockBalanceInquiry/1.0.0","");
        
        if(urlPostfix != "" && !gateway:hasPrefix(urlPostfix, "/")) {
            urlPostfix = "/" + urlPostfix;
        }
        http:Response|error clientResponse;
        http:Response r = new;
        clientResponse = r;
        string destination_attribute;
        invocationContext.attributes["timeStampRequestOut"] = time:currentTime().time;
        boolean reinitRequired = false;
        string failedEtcdKey = "";
        string failedEtcdKeyConfigValue = "";
        boolean|error hasUrlChanged;
        http:ClientConfiguration newConfig;
        boolean reinitFailed = false;
        boolean isProdEtcdEnabled = false;
        boolean isSandEtcdEnabled = false;
        map<string> endpointEtcdConfigValues = {};
        
            
            
                if("PRODUCTION" == <string>invocationContext.attributes["KEY_TYPE"]) {
                
                    
    clientResponse = Mock_space_KCB_space_Balance_space_inquiry__1_0_0_prod->forward(urlPostfix, <@untainted>req);

invocationContext.attributes["destination"] = gateway:retrieveConfig("prodEndPoint_prod_endpoint_0","http://192.168.1.103:8080");


                
                    } else {
                
                    http:Response res = new;
res.statusCode = 403;
string errorMessage = "Sandbox key offered to the API with no sandbox endpoint";
if (! invocationContext.attributes.hasKey(gateway:IS_GRPC)) {
    json payload = {
        ERROR_CODE: "900901",
        ERROR_MESSAGE: errorMessage
    };
    res.setPayload(payload);
} else {
    gateway:attachGrpcErrorHeaders (res, errorMessage);
}
invocationContext.attributes["error_code"] = "900901";
clientResponse = res;
                
                }
            
        
        
        invocationContext.attributes["timeStampResponseIn"] = time:currentTime().time;


        if(clientResponse is http:Response) {
            

            invocationContext.attributes[gateway:DID_EP_RESPOND] = true;
            var outboundResult = outboundEp->respond(clientResponse);
            if (outboundResult is error) {
                gateway:printError(Mock_space_KCB_space_Balance_space_inquiry__1_0_0Key, "Error when sending response", outboundResult);
            }
        } else {
            http:Response res = new;
            res.statusCode = 500;
            string errorMessage = clientResponse.reason();
            int errorCode = 101503;
            string errorDescription = "Error connecting to the back end";

            if(gateway:contains(errorMessage, "connection timed out") || gateway:contains(errorMessage,"Idle timeout triggered")) {
                errorCode = 101504;
                errorDescription = "Connection timed out";
            }
            if(gateway:contains(errorMessage, "Malformed URL")) {
                errorCode = 101505;
                errorDescription = "Malformed URL";
            }
            invocationContext.attributes["error_response_code"] = errorCode;
            invocationContext.attributes["error_response"] = errorDescription;
            if (! invocationContext.attributes.hasKey(gateway:IS_GRPC)) {
                json payload = {fault : {
                                code : errorCode,
                                message : "Runtime Error",
                                description : errorDescription
                            }};

                            res.setPayload(payload);
            } else {
                gateway:attachGrpcErrorHeaders (res, errorDescription);
            }
            gateway:printError(Mock_space_KCB_space_Balance_space_inquiry__1_0_0Key, "Error in client response", clientResponse);
            var outboundResult = outboundEp->respond(res);
            if (outboundResult is error) {
                gateway:printError(Mock_space_KCB_space_Balance_space_inquiry__1_0_0Key, "Error when sending response", outboundResult);
            }
        }
    }

}

    function handleExpectHeaderForMock_space_KCB_space_Balance_space_inquiry__1_0_0 (http:Caller outboundEp, http:Request req ) {
        if (req.expects100Continue()) {
            req.removeHeader("Expect");
            var result = outboundEp->continue();
            if (result is error) {
            gateway:printError(Mock_space_KCB_space_Balance_space_inquiry__1_0_0Key, "Error while sending 100 continue response", result);
            }
        }
    }

function getUrlOfEtcdKeyForReInitMock_space_KCB_space_Balance_space_inquiry__1_0_0(string defaultUrlRef,string etcdRef, string defaultUrl, string etcdKey) returns string {
    string retrievedEtcdKey = <string> gateway:retrieveConfig(etcdRef,etcdKey);
    map<any> urlChangedMap = gateway:getUrlChangedMap();
    urlChangedMap[<string> retrievedEtcdKey] = false;
    map<string> etcdUrls = gateway:getEtcdUrlsMap();
    string url = <string> etcdUrls[retrievedEtcdKey];
    if (url == "") {
        return <string> gateway:retrieveConfig(defaultUrlRef, defaultUrl);
    } else {
        return url;
    }
}

function respondFromJavaInterceptorMock_space_KCB_space_Balance_space_inquiry__1_0_0(runtime:InvocationContext invocationContext, http:Caller outboundEp) returns boolean {
    boolean tryRespond = false;
    if(invocationContext.attributes.hasKey(gateway:RESPOND_DONE) && invocationContext.attributes.hasKey(gateway:RESPONSE_OBJECT)) {
        if(<boolean>invocationContext.attributes[gateway:RESPOND_DONE]) {
            http:Response clientResponse = <http:Response>invocationContext.attributes[gateway:RESPONSE_OBJECT];
            var outboundResult = outboundEp->respond(clientResponse);
            if (outboundResult is error) {
                gateway:printError(Mock_space_KCB_space_Balance_space_inquiry__1_0_0Key, "Error when sending response from the interceptor", outboundResult);
            }
            tryRespond = true;
        }
    }
    return tryRespond;
}

function initInterceptorIndexesMock_space_KCB_space_Balance_space_inquiry__1_0_0() {


    
        

        
        


}