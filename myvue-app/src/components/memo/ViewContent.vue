<template>
    <div class="col-md-4 col-sm-12 col-xs-12 p-3" >
        <div class="card"  style="height: 350px">
            <img src="images/memo02.png"  class="card-img-top img img-thumbnail"  style="height: 100%" />
            <div class="card-img-overlay text-center">
                <form action="memoEdit.jsp" method="post" class="mt-2" @submit.prevent="editEnd">
                    <input type="hidden" v-model="memo.no" name="no"><p></p>
                    <input type="text" v-model="memo.title" name="title" placeholder="제목"  class="form-control" >
                    <p></p>
                    <textarea name="msg" v-model="memo.msg" placeholder="메모내용" class="form-control mt-2"></textarea>
                    <span class="badge badge-success">작성일: {{memo.wdate}}	</span><p></p>
                    <button type="submit" class="btn btn-outline-info">글수정</button>
                </form> 
            </div>
        </div> 
    </div>
</template>

<script>
    import eventBus from '../../eventBus/index.js';

    export default {
        data () {
            return {
                memo: {
                    no: '',
                    title: '',
                    msg: '',
                    wdate: ''
                }
            }
        },
        created () {
            var vm = this;
            eventBus.$on('show-view', function (tmpMemo) {
                vm.memo = {...tmpMemo};
            })
        },
        methods: {
            editEnd () {
                var tmpMemo = {...this.memo}
                this.$emit('edit-memo', tmpMemo);
            }
        }
    }
</script>

<style lang="scss" scoped>

</style>