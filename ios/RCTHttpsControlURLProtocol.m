#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "RCTHttpsControlURLProtocol.h"

@implementation HttpsControlURLProtocol
+ (BOOL)canInitWithRequest:(NSURLRequest *)request
{
    NSString *url = request.URL.absoluteString;
    return [url containsString:@":443"] && [url containsString:@"https"];
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request
{
    NSMutableURLRequest *modifiedRequest = [request mutableCopy];
    NSString *url = [request.URL.absoluteString stringByReplacingOccurrencesOfString:@":443" withString:@""];
    
    modifiedRequest.URL = [NSURL URLWithString:url];
    
    return modifiedRequest;
}

- (void)startLoading
{
    self.connection = [NSURLConnection connectionWithRequest:self.request delegate:self];
}

- (void)stopLoading
{
    [self.connection cancel];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.client URLProtocol:self didLoadData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.client URLProtocol:self didFailWithError:error];
    self.connection = nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.client URLProtocolDidFinishLoading:self];
    self.connection = nil;
}

@end
