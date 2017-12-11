//
//  EnterUnityViewController.m
//  Unity-iPhone
//
//  Created by Forever.H on 15/12/23.
//
//

#import "EnterUnityViewController.h"
#import "MyDataManager.h"
#import "UnityAppController+Rendering.h"

@interface EnterUnityViewController ()

@end

@implementation EnterUnityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)startUnity:(id)sender {
    [MyDataManager sharedManager].isInMyHomeView = true;
    
//    if([MyDataManager sharedManager].isRestartInUnity)
//    {
//        //判断是否是第一次启动unity
////        [[MyDataManager sharedManager].myAppDelegate orientUnity:UIInterfaceOrientationLandscapeLeft];
////        [MyDataManager sharedManager].myWindow.rootViewController = [MyDataManager sharedManager].unityViewController; //将存放在单例中的unityViewController变成当前的rootVC
////        [[MyDataManager sharedManager].myWindow bringSubviewToFront: [MyDataManager sharedManager].unityViewController.view];//将unityVC放到window的最上面
////        [[[UnityGetMainWindow() rootViewController] view]setHidden:NO]; //让unity的界面显示出来
////        [UnityGetMainWindow() makeKeyAndVisible];
//
//        UnityPause(false);
//        [[MyDataManager sharedManager].myAppDelegate setValue:[[MyDataManager sharedManager].myAppDelegate createRootViewController] forKey:@"_rootController"];
//        UIViewController *vc = [[MyDataManager sharedManager].myAppDelegate valueForKey:@"_rootController"];
//        [[MyDataManager sharedManager].myAppDelegate willStartWithViewController:vc];
//
//        [[MyDataManager sharedManager].myAppDelegate showGameUI];
//        [[MyDataManager sharedManager].myAppDelegate createDisplayLink];
//
//        [MyDataManager sharedManager].unityViewController = vc;
//        [MyDataManager sharedManager].unityViewController.view.hidden = NO;
//        [self presentViewController:vc animated:YES completion:^{
//
//        }];
//    }
//    else
//    {
        //如果是第一次启动unity，需要添加返回键
    UnityPause(false);
        [MyDataManager sharedManager].isRestartInUnity = true;
//        [[MyDataManager sharedManager].myAppDelegate startUnity:UIApplication.sharedApplication];//启动unity
//        [[MyDataManager sharedManager].myAppDelegate showGameUI];
        [[MyDataManager sharedManager].myAppDelegate setValue:[[MyDataManager sharedManager].myAppDelegate createRootViewController] forKey:@"_rootController"];
        UIViewController *vc = [[MyDataManager sharedManager].myAppDelegate valueForKey:@"_rootController"];
        [[MyDataManager sharedManager].myAppDelegate willStartWithViewController:vc];

        [[MyDataManager sharedManager].myAppDelegate showGameUI];
        [[MyDataManager sharedManager].myAppDelegate createDisplayLink];
        
        [MyDataManager sharedManager].unityViewController = vc;
        [MyDataManager sharedManager].unityViewController.view.hidden = NO;
        [self presentViewController:vc animated:YES completion:nil];
        
        //生成返回键
        UIView *pauseUnityView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
        [backBtn addTarget:self action:@selector(doExitSelector) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setBackgroundColor:[UIColor whiteColor]];
        [pauseUnityView addSubview:backBtn];
        
        [[MyDataManager sharedManager].unityViewController.view addSubview:pauseUnityView];
//    }
}

/**
 *  返回键函数
 */
- (void)doExitSelector{
    UnityPause(true); //跳转回iOS部分时需要暂停unity
//    [MyDataManager sharedManager].unityViewController = [MyDataManager sharedManager].myWindow.rootViewController; //将unity的rootVC存在单例中防止被释放掉
    
    [[MyDataManager sharedManager].unityViewController dismissViewControllerAnimated:YES completion:^{
        [MyDataManager sharedManager].unityViewController.view.hidden = YES;
        [[MyDataManager sharedManager].myAppDelegate destroyDisplayLink];
        [[MyDataManager sharedManager].myAppDelegate setValue:@(UIInterfaceOrientationUnknown) forKey:@"_curOrientation"];
    }];
    
//    [[[UnityGetMainWindow() rootViewController] view] setHidden:YES]; //隐藏Unity的rootVC
//    [MyDataManager sharedManager].myWindow.rootViewController = self; //将当前界面B作为当前window的rootVC
//
//    [UnityGetMainWindow() makeKeyAndVisible];
    
//    [[MyDataManager sharedManager].unityViewController.navigationController popViewControllerAnimated:YES];
}

@end
