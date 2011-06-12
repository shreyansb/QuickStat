#import "StatTextField.h"

@implementation StatTextField

#pragma mark UIView

- (id)initWithFrame:(CGRect)frame 
        placeholder:(NSString *)placeholder
{
    if ((self = [super initWithFrame:frame])) {
        self.borderStyle = UITextBorderStyleBezel;
        self.backgroundColor = [UIColor whiteColor];
        self.placeholder = NSLocalizedString(placeholder, nil);
    }
    return self;
}

@end
