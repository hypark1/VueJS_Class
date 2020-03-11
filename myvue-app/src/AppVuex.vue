<template>
    <div>
        <h1>{{$store.state.count}}</h1>
        <h1 style="color:red;">{{mycount}}</h1>
        <counter-comp></counter-comp>
        <counter-comp></counter-comp>
    </div>
</template>

<script>
    import Counter from './components/Counter.vue'

    export default {
        components: {
            'counter-comp': Counter
        },
        computed: {
            //$store에 있는 state의 데이터들은 computed를 통해 가져다 쓸 수 있다.
            mycount () {
                return this.$store.state.count
                // computed를 사용하여 vuex의 state를 가져 올 수 있다.
                // 반드시 computed를 이용해서 state를 가져오자.
            }
        }
    }
</script>

<style lang="scss" scoped>

</style>