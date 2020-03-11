<template>
    <div style="padding: 20px;">
        <button @click="plus">증가</button>
        <button @click="minus">감소</button>
    </div>
</template>

<script>
    export default {
        methods: {
            plus () {
                this.$store.commit('INCREMENT');
                //commit()을 통해서 mutations를 호출
            },
            minus () {
                this.$store.commit('DECREMENT');
            }
        },
    }
</script>

<style lang="scss" scoped>

</style>