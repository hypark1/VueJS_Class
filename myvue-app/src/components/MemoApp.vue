<template>
    <div class="row mt-4">
        <!-- 여기에 컴포넌트들 들어갈 예정-->
        <create-comp v-on:add-memo="memoAdd"></create-comp>
        <list-comp :memo-arr="memoArr"></list-comp>
        <view-content v-on:edit-memo="memoEdit"></view-content>
    </div>
</template>

<script>
    import CreateContent from './memo/CreateContent.vue';
    import ListContent from './memo/ListContent.vue';
    import ViewContent from './memo/ViewContent.vue';

    export default {
        data () {
            return{
                memoArr: []
            }
        },
        components: {
            'create-comp': CreateContent,
            'list-comp': ListContent,
            ViewContent
        },
        methods: {
            memoAdd (v) {
                this.memoArr.push(v);
                // localStorage.setItem('key', value)
                localStorage.setItem('memos', JSON.stringify(this.memoArr))
                // JSON.stringify() <==> JSON.parse()
            },
            memoEdit (val) {
                var idx;
                this.memoArr.map(function($value, index){
                    if ($value.no === val.no) {
                        idx = index;
                    }
                });
                // this.memoArr[idx] = val;
                this.$set(this.memoArr, idx, val);
            }
        },
        created () {
            var memos = localStorage.getItem('memos');
            if (memos != undefined) {
                this.memoArr = JSON.parse(memos);
            }
        }
    }
</script>

<style lang="scss" scoped>

</style>