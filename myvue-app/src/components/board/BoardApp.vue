<template>
    <div class="mt-4">
        <board-write></board-write>
        <board-list></board-list>
    </div>
</template>

<script>
    import BoardWrite from '@/components/board/BoardWrite.vue'
    import BoardList from './BoardList.vue'
    export default {
        components: {
            'board-write': BoardWrite,
            'board-list': BoardList
        }
    }
</script>

<style lang="scss" scoped>

</style>