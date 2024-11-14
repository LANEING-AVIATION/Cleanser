import winsdk.windows.ui.xaml as xaml
import winsdk.windows.ui.xaml.controls as controls
import winsdk.windows.ui.core as core
import winsdk.windows.applicationmodel.core as coreapp

# 创建一个应用程序视图
application_view = coreapp.CoreApplication.MainView
core_window = application_view.CoreWindow

# 创建一个窗口
window = xaml.Window(RequestedTheme=xaml.ElementTheme.Dark)  # 设置主题为暗色

# 创建一个网格布局作为窗口的内容
grid = controls.Grid()
window.Content = grid

# 创建一个按钮
button = controls.Button()
button.Content = "点击我"
button.Background = winsdk.windows.ui.Colors.Green  # 设置按钮背景为绿色
button.HorizontalAlignment = xaml.HorizontalAlignment.Center
button.VerticalAlignment = xaml.VerticalAlignment.Center

# 点击按钮时调用的函数
def button_clicked(sender, args):
    button.Background = winsdk.windows.ui.Colors.White  # 将按钮背景改为白色

# 将按钮添加到网格布局中
grid.Children.Add(button)

# 设置按钮点击事件
button.Click += button_clicked

# 设置窗口大小和位置
window.Width = 300
window.Height = 200
window.Activate()

# 将窗口放置在屏幕中央
window.Closed += lambda sender, args: core_window.Dispatcher.StopProcessEvents()
core_window.SizeChanged += lambda sender, args: window.CenterOnScreen()
window.CenterOnScreen()

# 运行消息循环
core_window.Dispatcher.ProcessEvents(core.CoreProcessEventsOption.ProcessAllItems)
