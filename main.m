#import <Foundation/Foundation.h>

void do_the_dir(NSString* directory)
{
    NSFileManager* fileManager = [[NSFileManager alloc] init];
    BOOL isDir;
    BOOL goodToGo = YES;
    if (![fileManager fileExistsAtPath:directory isDirectory:&isDir]) {
        printf("\nPath does not exist\n");
        goodToGo = NO;
    }
    else if(!isDir)
    {
        printf("\nPath is not a directory\n");
        goodToGo = NO;
    }
    
    if(goodToGo)
    {
        NSArray* subpaths = [fileManager subpathsAtPath:directory];
        NSMutableArray* newSubpaths = [[NSMutableArray alloc] init];
        printf("\n");
        for(NSString* subpath in subpaths)
        {
            if ([subpath hasSuffix:@".DS_Store"]) {
                [newSubpaths addObject:subpath];
                printf("%s\n", [subpath UTF8String]);
            }
        }
        if ([newSubpaths count] == 0) {
            printf("No ds stores found\n");
        }
        else
        {
            printf("\nDelete? (y/n) ");
            char response;
            scanf("%s", &response);
            if(response == 'y' || response == 'Y')
            {
                for(NSString* subpath in newSubpaths)
                    [fileManager removeItemAtPath:subpath error:nil];
                printf("\nDone\n");
            }
        }
    }
}

int main (int argc, const char * argv[])
{

    @autoreleasepool {
        NSString* directory;
        if(argc == 1)
        {
            char* working_directory = getcwd(0, 0);
            printf("\nUsing current working directory: %s\n", working_directory);
            directory = [NSString stringWithCString:working_directory encoding:NSUTF8StringEncoding];
            do_the_dir(directory);
        }
        else for(int i = 1; i < argc; i++)
        {
            directory = [NSString stringWithCString:argv[i] encoding:NSUTF8StringEncoding];
            do_the_dir(directory);
        }
                
        printf("\nBye\n");
    }
    return 0;
}



