import ballerina/http;
import ballerina/io;
import ballerina/log;
import ballerina/config;



string channelCode = config:getAsString("102");



public function validateRequest (http:Caller outboundEp, http:Request req) {
log:printInfo(io:sprintf("[fundsTransferRequest] [] [fundsTransferRequest]: begin"));
var jsonPayload = req.getJsonPayload();
// boolean hasApiKey = req.hasHeader("X-API-KEY");
// if (!hasApiKey) {
// log:printInfo(io:sprintf("No AML Invocation"));
// }
// else{
// log:printInfo(io:sprintf("API Invocation"));
// }
if (jsonPayload is json) {
req.setHeader("messageID",jsonPayload.header.messageID.toString());
}
req.setHeader("channelCode",channelCode);
log:printInfo(io:sprintf("[fundsTransferRequest] [] [fundsTransferRequest]: end"));
}