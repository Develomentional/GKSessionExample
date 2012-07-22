//  "MainViewController.m
//
//  Created by jeffry Bobb on 7/15/12.
//  Copyright (c) 2012 Develomentional,LLC All rights reserved.
//
#import "MainViewController.h"

@interface MainViewController ()<HostViewControllerDelegate, JoinViewControllerDelegate>
{
    
    BOOL _buttonsEnabled; 
}


@property (nonatomic, weak) IBOutlet UIButton *hostGameButton;
@property (nonatomic, weak) IBOutlet UIButton *joinGameButton;
@property (nonatomic, weak) IBOutlet UIButton *singlePlayerGameButton;
@end

@implementation MainViewController


@synthesize hostGameButton = _hostGameButton;
@synthesize joinGameButton = _joinGameButton;
@synthesize singlePlayerGameButton = _singlePlayerGameButton;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationPortrait;
}

- (IBAction)hostGameAction:(id)sender
{
    if (_buttonsEnabled)
         {	
             HostViewController *controller = [[HostViewController alloc] initWithNibName:@"HostViewController" bundle:nil];
             controller.delegate = self;
             
                 //only works if using xib
                 [self presentViewController:controller animated:NO completion:nil];
         	}
}

- (IBAction)joinGameAction:(id)sender
{
    if (_buttonsEnabled)
	{
		             JoinViewController *controller = [[JoinViewController alloc] initWithNibName:@"JoinViewController" bundle:nil];
             controller.delegate = self;
             
           //only works if using xib
            [self presentViewController:controller animated:NO completion:nil];
    
	}
}

- (IBAction)singlePlayerGameAction:(id)sender
{
}
#pragma mark view lifecycle
-(void)viewDidLoad{
    
       
}
- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
    
}
- (void)dealloc
{
#ifdef DEBUG
	NSLog(@"dealloc %@", self);
#endif
}

#pragma mark - HostViewControllerDelegate
- (void)hostViewController:(HostViewController *)controller didEndSessionWithReason:(QuitReason)reason
{
	if (reason == QuitReasonNoNetwork)
	{
		[self showNoNetworkAlert];
	}
}

- (void)hostViewControllerDidCancel:(HostViewController *)controller
{
	[self dismissViewControllerAnimated:NO completion:nil];
        //not needed if using xib
    [self dismissModalViewControllerAnimated:YES];
}
#pragma mark - JoinViewControllerDelegate
- (void)joinViewController:(JoinViewController *)controller didDisconnectWithReason:(QuitReason)reason
{
	if (reason == QuitReasonNoNetwork)
	{
		[self showNoNetworkAlert];
	}
	else if (reason == QuitReasonConnectionDropped)
	{
        //not needed if using xib
        [self dismissModalViewControllerAnimated:YES];
            //only put this here because the completion block doesnt get called if presented modally
        [self showDisconnectedAlert];

        [self dismissViewControllerAnimated:NO completion:^
         {
             [self showDisconnectedAlert];
         }];
	}}

- (void)joinViewControllerDidCancel:(JoinViewController *)controller
{
	[self dismissViewControllerAnimated:NO completion:nil];
   
        //not needed if using xib
    [self dismissModalViewControllerAnimated:YES];
}
#pragma mark - network alerts
- (void)showDisconnectedAlert
{
	UIAlertView *alertView = [[UIAlertView alloc] 
                              initWithTitle:NSLocalizedString(@"Disconnected", @"Client disconnected alert title")
                              message:NSLocalizedString(@"You were disconnected from the game.", @"Client disconnected alert message")
                              delegate:nil
                              cancelButtonTitle:NSLocalizedString(@"OK", @"Button: OK")
                              otherButtonTitles:nil];
    
	[alertView show];
}
- (void)showNoNetworkAlert
{
	UIAlertView *alertView = [[UIAlertView alloc] 
                              initWithTitle:NSLocalizedString(@"No Network", @"No network alert title")
                              message:NSLocalizedString(@"To use multiplayer, please enable Bluetooth or Wi-Fi in your device's Settings.", @"No network alert message")
                              delegate:nil
                              cancelButtonTitle:NSLocalizedString(@"OK", @"Button: OK")
                              otherButtonTitles:nil];
    
	[alertView show];
}

@end
