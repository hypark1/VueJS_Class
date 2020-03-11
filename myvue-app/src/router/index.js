import Vue from 'vue';
import VueRouter from 'vue-router';
import Home from '../components/Home.vue';
import MemoApp from '../components/MemoApp.vue';
import SignUp from '../components/user/SignUp.vue';
import BoardApp from '../components/board/BoardApp.vue';
import NotFound from '../components/NotFound.vue';

Vue.use(VueRouter);

export default new VueRouter ({
    base: '/',
    mode: 'history',
    routes: [
        {
            path: '/',
            name: 'Home',
            component: Home
        },
        {
            path: '/memo',
            name: 'MemoApp',
            component: MemoApp
        },
        {
            path: '/signup',
            name: 'SignUp',
            component: SignUp
        },
        {
            path: '/board',
            name: 'BoardApp',
            component: BoardApp
        },
        {
            path: '*',
            name: 'NotFound',
            component: NotFound
        }
    ]
})