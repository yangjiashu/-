### el-form

属性：`model`指定data中的form对象，`label-width`执行标签的宽度，`:inline`指定是否为行内表单，`:label-position`（left,right,top)指定标签的对其方式。

属性：`:rules`对应验证规则

### el-item-xxx

属性：`v-model`指定data中form对象的字段值(完整引用：formdata.name)，`value`如果是下拉菜单则为data取值，如果是单选框或者复选框，`label`表示data取值

### el-item

属性：`prop`属性为需要验证的字段名(只需要填字段名字符串)，`label`制定显示的标签

### 验证写法

input组件除了使用验证，自己也有最大最小长度限制的属性

`trigger: 'blur/change'` 表示触发方式不同，blur表示失去焦点，change表示内容改变

## el-table

`:data`属性注入data对象数组，然后在`el-table-column`中用`prop`属性来对应对象中的键名即可填入数据，并用`label`属性来定义表格的列名，用`width`定义列宽

`stripe`属性定义斑马纹

`border`属性定义边框

`height`属性只要定义了就会固定表头，当表很长时会出现滚动条，并且表头不会移动

template标签加上`slot-scop`属性值为`scope`，可以通过`scope.row`，`scope.column`, `scope.$index`, `scope.store`访问表格的数据

## el-tooltip

用el-tooltip包裹其他的标签，使得其他的标签hover时有提示文字

`content`属性，提示内容

`placement`属性，提示内容显示的位置：取值有`top-start`, `top-end`, `top`, `left-start`, `left`, `left-end`, ...