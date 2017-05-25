  使用的时候只需要将LVMProductPageControl这两个文件导入到自己工程里面，就可以直接使用。

- (void)changePage:(NSInteger)numberPage withFrame:(CGSize)size withText:(NSString *)text withImage:(NSString *)image

你可以通过这个方法去设置特定某一个page，支持文字显示和图片显示。如果你没有修改，就默认为圆点类型。

LVMProductPageControl.h文件里面还开放了很多属性，可以自定义颜色，距离，放大比例等。

你可以通过Demo进行了解。
