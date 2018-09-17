 # iOS程序执行顺序和UIViewController 的生命周期(整理)
====================================


### [iOS程序的启动执行顺序 AppDelegate 及 UIViewController 的生命周期](https://link.jianshu.com?t=http%3A%2F%2Fwww.cnblogs.com%2Fjunhuawang%2Fp%2F5742535.html)

### [UIView的生命周期](https://link.jianshu.com?t=https%3A%2F%2Fbestswifter.com%2Fuiviewlifetime%2F)


一. iOS程序的启动执行顺序
===============

**程序启动顺序图**  

![](https://ws2.sinaimg.cn/large/006tNbRwgy1fvcreua510j30ri0jx41h.jpg)

**具体执行流程**

1.  程序入口  
    进入<font color = red>`main`</font>函数，设置<font color = red>`AppDelegate`</font>称为函数的代理
    
2.  程序完成加载  
   <font color = red> `[AppDelegate application:didFinishLaunchingWithOptions:]`</font>
    
3.  创建<font color = red>`window`</font>窗口
    
4.  程序被激活  
    <font color = red>`[AppDelegate applicationDidBecomeActive:]` </font>
    
5.  当点击<font color = red>`command+H`</font>时(针对模拟器,手机是当点击<font color = red>`home键`</font>)  
    程序取消激活状态  
    <font color = red> `[AppDelegate applicationWillResignActive:];`  </font>
    程序进入后台  
    <font color = red> `[AppDelegate applicationDidEnterBackground:];` </font>
    
6.  点击进入工程  
    程序进入前台  
     <font color = red> `[AppDelegate applicationWillEnterForeground:]` </font> 
    程序被激活  
    <font color = red>  `[AppDelegate applicationDidBecomeActive:];`</font>
    

**分析**

**1\. 对于 <font color = red> `applicationWillResignActive(非活动)`</font>与 <font color = red> `applicationDidEnterBackground(后台)`</font>这两个的区别**

*   <font color = red> `applicationWillResignActive(非活动)`</font>:  
    比如当有电话进来或短信进来或锁屏等情况下，这时应用程序挂起进入非活动状态，也就是手机界面还是显示着你当前的应用程序的窗口，只不过被别的任务强制占用了，也可能是即将进入后台状态(因为要先进入非活动状态然后进入后台状态)
    
* <font color = red> `applicationDidEnterBackground(后台)`</font>:  
    指当前窗口不是你的App,大多数程序进入这个后台会在这个状态上停留一会，时间到之后会进入`挂起状态(Suspended)`。如果你程序特殊处理后可以长期处于后台状态也可以运行。  
    <font color = red> `Suspended (挂起)` </font> : 程序在后台不能执行代码。系统会自动把程序变成这个状态而且不会发出通知。当挂起时，程序还是停留在内存中的，当系统内存低时，系统就把挂起的程序清除掉，为前台程序提供更多的内存。
    

如下图所示:

![](https://ws4.sinaimg.cn/large/006tNbRwgy1fvcrl02jd2j30at0c8q3i.jpg)

**2. <font color = red>`UIApplicationMain` </font> 函数解释:**

入口函数:

    int main(int argc, char * argv[]) {  
          @autoreleasepool {  
              return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));    
        } 
    }
    
     UIApplicationMain(int argc, char *argv[], NSString *principalClassName, NSString *delegateClassName);
    

*   **<font color = red>`argc`</font>**和**<font color = red>`argv`</font>** 参数是为了与C语言保持一致。
    
*   **<font color = red>`principalClassName (主要类名)`</font>** 和 ** <font color = red>`delegateClassName (委托类名)`</font>**。  
    (1) 如果<font color = red>`principalClassName`</font>是nil，那么它的值将从<font color = red>`Info.plist`</font>去获取，如果<font color = red>`Info.plist`</font>没有，则默认为<font color = red>`UIApplication`</font>。<font color = red>`principalClass`</font>这个类除了管理整个程序的生命周期之外什么都不做，它只负责监听事件然后交给<font color = red>`delegateClass`</font>去做。  
    (2) <font color = red>`delegateClass`</font> 将在工程新建时实例化一个对象。<font color = red>`NSStringFromClass([AppDelegate class])`</font>
    
*   **<font color = red>`AppDelegate` 类实现文件</font> **
    
    ```
    
     - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        NSLog(@"--- %s ---",__func__);//__func__打印方法名
        return YES;
    }
    
    
    - (void)applicationWillResignActive:(UIApplication *)application {
         NSLog(@"--- %s ---",__func__);
    }
    
    
    - (void)applicationDidEnterBackground:(UIApplication *)application {
       NSLog(@"--- %s ---",__func__);
    }
    
    
    - (void)applicationWillEnterForeground:(UIApplication *)application {
       NSLog(@"--- %s ---",__func__);
    }
    
    
    - (void)applicationDidBecomeActive:(UIApplication *)application {
      NSLog(@"--- %s ---",__func__);
    }
    
    
    - (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
         NSLog(@"--- %s ---",__func__);
    }
    
    - (void)applicationWillTerminate:(UIApplication *)application {
        NSLog(@"--- %s ---",__func__);
    }
    

    ```

**打印调用顺序**  
**启动程序**

     --- -[AppDelegate application:didFinishLaunchingWithOptions:] ---
     --- -[AppDelegate applicationDidBecomeActive:] ---
    

**按下 `Command + H + SHIFT`**

    --- -[AppDelegate applicationWillResignActive:] ---
    --- -[AppDelegate applicationDidEnterBackground:] ---
    

**重新点击 进入程序**

    --- -[AppDelegate applicationWillEnterForeground:] ---
    --- -[AppDelegate applicationDidBecomeActive:] ---
    

**选择 模拟器的`Simulate Memory Warning`**

    --- -[AppDelegate applicationDidReceiveMemoryWarning:] ---
    




**分析:**

1. <font color = red>`application:didFinishLaunchingWithOptions`</font>:  
程序首次已经完成启动时执行，一般在这个函数里创建window对象，将程序内容通过window呈现给用户。

2.  <font color = red>`applicationWillResignActive(非活动)` </font> 
    程序将要失去<font color = red>`Active`</font>状态时调用，比如有<font color = red>`电话`</font>进来或者按下<font color = red>`Home键`</font>，之后程序进入后台状态，对应的<font color = red>`applicationWillEnterForeground(即将进入前台)`</font>方法。

该函数里面主要执行操作:  
a . 暂停正在执行的任务  
b. 禁止计时器  
c. 减少<font color = red>`OpenGL ES`</font>帧率  
d. 若为游戏应暂停游戏

3.<font color = red>`applicationDidEnterBackground(已经进入后台)`  </font>
对应<font color = red>`applicationDidBecomeActive(已经变成前台)`</font>

该方法用来:  
a. 释放共享资源  
b. 保存用户数据(写到硬盘)  
c. 作废计时器  
d. 保存足够的程序状态以便下次修复;

4.  <font color = red>`applicationWillEnterForeground(即将进入前台)` </font> 
    程序即将进入前台时调用，对应<font color = red>`applicationWillResignActive(即将进入后台)`</font>，  
    这个方法用来: 撤销<font color = red>`applicationWillResignActive`</font>中做的改变。
    
5.  <font color = red>`applicationDidBecomeActive(已经进入前台)` </font> 
    程序已经变为<font color = red>`Active(前台)`</font>时调用。对应<font color = red>`applicationDidEnterBackground(已经进入后台)`</font>。  
    注意: 若程序之前在后台，在此方法内刷新用户界面
    
6.  <font color = red>`applicationWillTerminate`</font>  
    程序即将退出时调用。记得保存数据，如<font color = red>`applicationDidEnterBackground`</font>方法一样。
    





---------------------------
<br>
<br>






二. `UIViewController` 的 生命周期
============================

**代码 示例**

    #pragma mark --- life circle
    
    // 非storyBoard(xib或非xib)都走这个方法
    - (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
        NSLog(@"%s", __FUNCTION__);
        if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        }
        return self;
    }
    
    // 如果连接了串联图storyBoard 走这个方法
    - (instancetype)initWithCoder:(NSCoder *)aDecoder {
         NSLog(@"%s", __FUNCTION__);
        if (self = [super initWithCoder:aDecoder]) {
            
        }
        return self;
    }
    
    // xib 加载 完成
    - (void)awakeFromNib {
        [super awakeFromNib];
         NSLog(@"%s", __FUNCTION__);
    }
    
    // 加载视图(默认从nib)
    - (void)loadView {
        NSLog(@"%s", __FUNCTION__);
        self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.view.backgroundColor = [UIColor redColor];
    }
    
    //视图控制器中的视图加载完成，viewController自带的view加载完成
    - (void)viewDidLoad {
        NSLog(@"%s", __FUNCTION__);
        [super viewDidLoad];
    }
    
    
    //视图将要出现
    - (void)viewWillAppear:(BOOL)animated {
        NSLog(@"%s", __FUNCTION__);
        [super viewWillAppear:animated];
    }
    
    // view 即将布局其 Subviews
    - (void)viewWillLayoutSubviews {
        NSLog(@"%s", __FUNCTION__);
        [super viewWillLayoutSubviews];
    }
    
    // view 已经布局其 Subviews
    - (void)viewDidLayoutSubviews {
        NSLog(@"%s", __FUNCTION__);
        [super viewDidLayoutSubviews];
    }
    
    //视图已经出现
    - (void)viewDidAppear:(BOOL)animated {
        NSLog(@"%s", __FUNCTION__);
        [super viewDidAppear:animated];
    }
    
    //视图将要消失
    - (void)viewWillDisappear:(BOOL)animated {
        NSLog(@"%s", __FUNCTION__);
        [super viewWillDisappear:animated];
    }
    
    //视图已经消失
    - (void)viewDidDisappear:(BOOL)animated {
        NSLog(@"%s", __FUNCTION__);
        [super viewDidDisappear:animated];
    }
    
    //出现内存警告  //模拟内存警告:点击模拟器->hardware-> Simulate Memory Warning
    - (void)didReceiveMemoryWarning {
        NSLog(@"%s", __FUNCTION__);
        [super didReceiveMemoryWarning];
    }
    
    // 视图被销毁
    - (void)dealloc {
        NSLog(@"%s", __FUNCTION__);
    }
    

\*\* 查看 打印 结果 **

    2017-03-01 18:03:41.577 ViewControllerLifeCircle[32254:401790] -[ViewController initWithCoder:]
    2017-03-01 18:03:41.579 ViewControllerLifeCircle[32254:401790] -[ViewController awakeFromNib]
    2017-03-01 18:03:41.581 ViewControllerLifeCircle[32254:401790] -[ViewController loadView]
    2017-03-01 18:03:46.485 ViewControllerLifeCircle[32254:401790] -[ViewController viewDidLoad]
    2017-03-01 18:03:46.486 ViewControllerLifeCircle[32254:401790] -[ViewController viewWillAppear:]
    2017-03-01 18:03:46.487 ViewControllerLifeCircle[32254:401790] -[ViewController viewWillLayoutSubviews]
    2017-03-01 18:03:46.488 ViewControllerLifeCircle[32254:401790] -[ViewController viewDidLayoutSubviews]
    2017-03-01 18:03:46.488 ViewControllerLifeCircle[32254:401790] -[ViewController viewWillLayoutSubviews]
    2017-03-01 18:03:46.488 ViewControllerLifeCircle[32254:401790] -[ViewController viewDidLayoutSubviews]
    2017-03-01 18:03:46.490 ViewControllerLifeCircle[32254:401790] -[ViewController viewDidAppear:]
    2017-03-01 19:03:13.308 ViewControllerLifeCircle[32611:427962] -[ViewController viewWillDisappear:]
    2017-03-01 19:03:14.683 ViewControllerLifeCircle[32611:427962] -[ViewController viewDidDisappear:]
    2017-03-01 19:03:14.683 ViewControllerLifeCircle[32611:427962] -[ViewController dealloc]
    2017-03-01 19:12:05.927 ViewControllerLifeCircle[32611:427962] -[ViewController didReceiveMemoryWarning]
    

** 分析 **  
**1.<font color = red>`initWithNibName:bundle`</font>:**  
初始化<font color = red>`UIViewController`</font>，执行关键数据初始化操作，非<font color = red>`StoryBoard`</font>创建<font color = red>`UIViewController`</font>都会调用这个方法。  
** 注意: 不要在这里做<font color = red>`View`</font>相关操作，<font color = red>`View`</font>在<font color = red>`loadView`</font>方法中才初始化。**

**2\. <font color = red>`initWithCoder:`</font>**  
如果使用<font color = red>`StoryBoard`</font>进行视图管理，程序不会直接初始化一个<font color = red>`UIViewController`</font>，<font color = red>`StoryBoard`</font>会自动初始化或在<font color = red>`segue`</font>被触发时自动初始化，因此方法<font color = red>`initWithNibName:bundle`</font>不会被调用，但是<font color = red>`initWithCoder`</font>会被调用。

**3\. <font color = red>`awakeFromNib`</font>**  
当<font color = red>`awakeFromNib`</font>方法被调用时，所有视图的<font color = red>`outlet`</font>和<font color = red>`action`</font>已经连接，但还没有被确定，这个方法可以算作适合视图控制器的实例化配合一起使用的，因为有些需要根据用户喜好来进行设置的内容，无法存在<font color = red>`storyBoard`</font>或<font color = red>`xib`</font>中，所以可以在<font color = red>`awakeFromNib`</font>方法中被加载进来。

**4\. <font color = red>`loadView`</font>**  
当执行到<font color = red>`loadView`</font>方法时，如果视图控制器是通过<font color = red>`nib`</font>创建，那么视图控制器已经从<font color = red>`nib`</font>文件中被解档并创建好了，接下来任务就是对<font color = red>`view`</font>进行初始化。

<font color = red>`loadView`</font>方法在<font color = red>`UIViewController`</font>对象的<font color = red>`view`</font>被访问且为空的时候调用。这是它与<font color = red>`awakeFromNib`</font>方法的一个区别。  
假设我们在处理内存警告时释放<font color = red>`view`</font>属性:<font color = red>`self.view = nil`</font>。因此<font color = red>`loadView`</font>方法在视图控制器的生命周期内可能被调用多次。  
<font color = red>`loadView`</font>方法不应该直接被调用，而是由系统调用。它会加载或创建一个view并把它赋值给<font color = red>`UIViewController`</font>的<font color = red>`view`</font>属性。

在创建<font color = red>`view`</font>的过程中，首先会根据<font color = red>`nibName`</font>去找对应的<font color = red>`nib`</font>文件然后加载。如果<font color = red>`nibName`</font>为空或找不到对应的<font color = red>`nib`</font>文件，则会创建一个空视图(这种情况一般是纯代码)

**注意:在重写loadView方法的时候，不要调用父类的方法。**

**5\. <font color = red>`viewDidLoad`</font>**  
当<font color = red>`loadView`</font>将<font color = red>`view`</font>载入内存中，会进一步调用<font color = red>`viewDidLoad`</font>方法来进行进一步设置。此时，视图层次已经放到内存中，通常，我们对于各种初始化数据的载入，初始设定、修改约束、移除视图等很多操作都可以这个方法中实现。

**视图层次(view hierachy):**因为每个视图都有自己的子视图，这个视图层次其实也可以理解为一颗树状的数据结构。而树的根节点，也就是<font color = red>`根视图(root view)`</font>,在<font color = red>`UIViewController`</font>中以<font color = red>`view`</font>属性。它可以看做是其他所有子视图的容器，也就是根节点。  
**6\. <font color = red>`viewWillAppear`</font>**  
系统在载入所有的数据后，将会在屏幕上显示视图，这时会先调用这个方法，通常我们会在这个方法对即将显示的视图做进一步的设置。比如，设置设备不同方向时该如何显示；设置状态栏方向、设置视图显示样式等。

另一方面，当<font color = red>`APP`</font>有多个视图时，上下级视图切换是也会调用这个方法，如果在调入视图时，需要对数据做更新，就只能在这个方法内实现。

**7\. <font color = red>`viewWillLayoutSubviews`</font>**  
<font color = red>`view`</font> 即将布局其<font color = red>`Subviews`</font>。 比如<font color = red>`view`</font>的<font color = red>`bounds`</font>改变了(例如:状态栏从不显示到显示,视图方向变化)，要调整<font color = red>`Subviews`</font>的位置，在调整之前要做的工作可以放在该方法中实现

**8.<font color = red>`viewDidLayoutSubviews`</font>**  
<font color = red>`view`</font>已经布局其<font color = red>`Subviews`</font>，这里可以放置调整完成之后需要做的工作。

**9\. <font color = red>`viewDidAppear`</font>**  
在view被添加到视图层级中以及多视图，上下级视图切换时调用这个方法，在这里可以对正在显示的视图做进一步的设置。

**10.<font color = red>`viewWillDisappear`</font>**  
在视图切换时，当前视图在即将被移除、或被覆盖是，会调用该方法，此时还没有调用<font color = red>`removeFromSuperview`</font>。

**11\. <font color = red>`viewDidDisappear`</font>**  
<font color = red>`view`</font>已经消失或被覆盖，此时已经调用<font color = red>`removeFromSuperView`</font>;

**12\. <font color = red>`dealloc`</font>**  
视图被销毁，此次需要对你在<font color = red>`init`</font>和<font color = red>`viewDidLoad`</font>中创建的对象进行释放。

**13.<font color = red>`didReceiveMemoryWarning`</font>**  
在内存足够的情况下，<font color = red>`app`</font>的视图通常会一直保存在内存中，但是如果内存不够，一些没有正在显示的<font color = red>`viewController`</font>就会收到内存不足的警告，然后就会释放自己拥有的视图，以达到释放内存的目的。但是系统只会释放内存，并不会释放对象的所有权，所以通常我们需要在这里将不需要显示在内存中保留的对象释放它的所有权，将其指针置<font color = red>`nil`</font>。

三. 视图的生命历程
==========

*   **<font color = red>`[ViewController initWithCoder:]`</font>或<font color = red>`[ViewController initWithNibName:Bundle]`</font>:** 首先从归档文件中加载<font color = red>`UIViewController`</font>对象。即使是纯代码，也会把<font color = red>`nil`</font>作为参数传给后者。
*   **<font color = red>`[UIView awakeFromNib]:`</font>** 作为第一个方法的助手，方法处理一些额外的设置。
*   **<font color = red>`[ViewController loadView]`</font>:**创建或加载一个<font color = red>`view`</font>并把它赋值给<font color = red>`UIViewController`</font>的<font color = red>`view`</font>属性。  
    -**<font color = red>`[ViewController viewDidLoad]`</font>:** 此时整个<font color = red>`视图层次(view hierarchy)`</font>已经放到内存中，可以移除一些视图，修改约束，加载数据等。
*   **<font color = red>`[ViewController viewWillAppear:]`</font>:** 视图加载完成，并即将显示在屏幕上。还没设置动画，可以改变当前屏幕方向或状态栏的风格等。
*   **<font color = red>`[ViewController viewWillLayoutSubviews]`</font>**即将开始子视图位置布局
*   **<font color = red>`[ViewController viewDidLayoutSubviews]`</font>**用于通知视图的位置布局已经完成
*   **<font color = red>`[ViewController viewDidAppear:]`</font>:**视图已经展示在屏幕上，可以对视图做一些关于展示效果方面的修改。
*   **<font color = red>`[ViewController viewWillDisappear:]`</font>:**视图即将消失
*   **<font color = red>`[ViewController viewDidDisappear:]`</font>:**视图已经消失
*   **<font color = red>`[ViewController dealloc:]`</font>:**视图销毁的时候调用

四: 总结:
======

*   只有<font color = red>`init`</font>系列的方法,如<font color = red>`initWithNibName`</font>需要自己调用，其他方法如<font color = red>`loadView`</font>和<font color = red>`awakeFromNib`</font>则是系统自动调用。而<font color = red>`viewWill/Did`</font>系列的方法则类似于回调和通知，也会被自动调用。
    
*   纯代码写视图布局时需要注意，要手动调用<font color = red>`loadView`</font>方法，而且不要调用父类的<font color = red>`loadView`</font>方法。纯代码和用<font color = red>`IB`</font>的区别仅存在于<font color = red>`loadView`</font>方法及其之前，编程时需要注意的也就是<font color = red>`loadView`</font>方法。
    
*   除了<font color = red>`initWithNibName`</font>和<font color = red>`awakeFromNib`</font>方法是处理视图控制器外，其他方法都是处理视图。这两个方法在视图控制器的生命周期里只会调用一次。
  