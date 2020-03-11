import Vue from 'vue';
import Vuex from 'vuex'
Vue.use(Vuex)

const store = new Vuex.Store({
    state: {
        //data와 유사함
        count: 0
    },
    mutations: {
        //methods와 유사함, 상태를 변경하는 내용을 기술.
        //대문자로 기술. commit()을 통해서 호출.
        INCREMENT () {
            this.state.count += 1;
        },
        DECREMENT () {
            this.state.count -= 1;
        }
    }
});

export default store;
