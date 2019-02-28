#import <Foundation/Foundation.h>

@interface HttpsControlURLProtocol : NSURLProtocol

@property (nonatomic, strong) NSURLConnection *connection;

+ (BOOL)canInitWithRequest:(NSURLRequest *)request;
+ (NSURLRequest *)canonicalRequestForRequest:( NSURLRequest *)request;
- (void)startLoading;
- (void)stopLoading;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

@end
