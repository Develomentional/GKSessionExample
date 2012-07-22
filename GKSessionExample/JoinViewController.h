//
//  JoinViewController.h
//
//  Created by jeffry Bobb on 7/15/12.
//  Copyright (c) 2012 Develomentional,LLC All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import "MatchmakingClient.h"

@class JoinViewController;

@protocol JoinViewControllerDelegate <NSObject>

- (void)joinViewControllerDidCancel:(JoinViewController *)controller;
- (void)joinViewController:(JoinViewController *)controller didDisconnectWithReason:(QuitReason)reason;

@end

@interface JoinViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, MatchmakingClientDelegate>
{
    MatchmakingClient *_matchmakingClient;
    QuitReason _quitReason;

    
}

@property (nonatomic, weak) id <JoinViewControllerDelegate> delegate;

@end
