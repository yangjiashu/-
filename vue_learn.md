### 动画

vue动画分为两种

1. css过度
2. css动画

在Html标签中使用动画的元素要用`<transition>`标签包裹起来，并且用`name`属性指定动画名，用于在样式文件中设定动画样式。通常要使用动画的元素用`v-if`控制进入和离开。

#### 1.css过渡

在进入/离开的过程中有6个class切换
1. `v-enter`: 进入时的初始状态。即被插入之前的状态，插入动作时第一帧就会移除。
2. `v-enter-active`: 定义过渡时期的状态，与css中的`transition`属性配合使用。
3. `v-enter-to`: 定义进入动作结束时的状态，在插入动作的第一帧开始生效，与`v-enter`属性的消失同时发生。
4. `v-leave`,`v-leave-active`,`v-leave-to`: 离开动作，与进入动作同理。

#### 2.css动画

使用`animation`和`keyframe`的组合来使用，类和css过渡中的类一样。但是只需要设定`v-enter-active`和`v-leave-active`就可以了。

#### 自定义过渡的类名：和第三方库配合使用

需要提前了解第三方库

### 状态过度

## 用vue-cli创建项目

**完整引入**

在main.js中编写

```javascript
import Vue from 'vue';
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import App from './App.vue';

Vue.use(ElementUI);

new Vue({
    el: '#app',
    render: h => h(App)
});
```

## Vuex

Vuex使用**单一状态树**，一个对象包含全部应用层级的状态。成为一个唯一数据源。表示每个应用只包含一个store实例。

要获取store实例中的state一般用Vue实例的计算属性，因为store实例的数据也是响应式的，即store属性的改变会引起计算属性的改变。

取得store值：`store.state.xxx`，设置store值：`store.commit(xxx)`。

### getter

可以在store中定义getter（可以认为是store的计算属性）。

getter接受state作为第一个参数。getter会暴露`store.getters`对象，可以以属性的方式访问这些值：`store.getters.doneTodos`

getter也可以接受其他getter作为第二个参数。同时使用state和getter，相当于在一个Vue实例中同时使用data和computed。

getter除了返回对象，也可以返回函数来实现给getter传参，这个和computed就不一样了，可以自定义参数。
```javascript
getters: {
    getTodoById: (state) => (id) => {
        return state.todos.find(todo => todo.id === id) // 一组对象
    }
}
------------------------------------
store.getter.getTodoById(2)
```

### mutation

更改Vuex的store中的状态唯一方法是提交mutation。mutation非常类似于事件，每个mutation都有一个字符串的事件类型和一个回调函数。这个回调函数将state作为第一个参数。

可以向store.commit传入额外的参数，即mutation的载荷：
```javascript
mutation: {
    increment (state, n) {
        state.count += n
    }
}
```
### action

Action和mutation的区别

* Action 提交的是mutation， 而不是直接变更状态，即间接地变更状态。
* Action 可以包含异步操作。

```javascript
mutations: {
    increment (state) {
        state.count++
    },
}
actions : {
    increment (context) {
        context.commit('increment')
    }
}
```

context对象和store具有相同方法和属性。可以使用参数结构来简化代码。例如将commit方法属性结构：

```javascript
actions: {
    increment ({commit}) {
        commit('increment')
    }
}
```

**触发action的方法**

`store.dispatch('increment')` 

**触发mutation的方法**

`store.commit('increment')`

store.dispatch可以和Promise相结合。


### Module（第一次接触)

Vuex允许将store分成模块，每个模块有自己的state、mutation、action、getter，甚至还可以嵌套。

模块内部的mutation和getter，接受的第一个参数是模块的局部状态对象。

```javascript
const moduleA = {
    state: () => ({...}),
    mutations: {
        xxx (state) { // 这里的state是局部的
        }
    },
    getters: {
        xxx (state) { // 这里的state也是局部的
        }
    }
}
```

同样，对于action，局部状态通过`context.state`暴露，根节点的状态可以用`context.rootState`访问。

getter也可以访问根节点的状态：`xxx(state, getters, rootSate`。

默认情况下，模块内部的action、mutation和getter是注册到全局命名空间中的，使得多个模块能够对同一mutation或action作出响应。
