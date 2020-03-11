<template>
    <div class="col-md-4 col-sm-12 col-xs-12 p-3">
        <div class="card" style="height: 350px">
            <div class="card-header text-center">
            <h3 class="text-center text-success">♣한줄 Memo♣</h3>
            </div>
            <div class="card-body text-center">
            <form action="memoAdd.jsp" method="post" @submit.prevent="save">
                <input type="text"
                v-model="memo.title"
                ref="title"
                name="title" placeholder="제  목"
                class="form-control">
                <p>
                <textarea v-model="memo.msg" name="msg" placeholder="메모 내용" class="form-control"></textarea>
                </p>
                <button class="btn btn-outline-success">글쓰기</button>
            </form> 
            </div>
            
        </div> 
    </div>
</template>

<script>
    export default {
        data () {
            return {
                memo: {
                    no: 0,
                    title: '',
                    msg: '',
                    wdate: ''
                },
                memoArr: []
            }
        },
        methods: {
            save () {
                //alert(e);
                //e.preventDefault(); //이벤트 기본 동작을 중지시킴
                var d = new Date();
                var today = d.getFullYear() + '-' + (d.getMonth() +1) + '-' + d.getDate();
                var memos = JSON.parse(localStorage.getItem('memos'));
                if (memos != undefined) {
                    this.memo.no = memos.length +1;
                } else {
                    this.memo.no += 1;
                }
                this.memo.wdate = today;
                //부모 컴포넌트(MemoApp)에 방금 작성한 글을 전달하자.
                //이벤트로 전달 $emit('이벤트이름', 데이터)
                var tmpMemo = {...this.memo};
                //this.memo의 사본을 spread연산자를 이용하여 만들고 전달하자.
                this.$emit('add-memo', tmpMemo);
                this.memo.title = '';
                this.memo.msg = '';
                this.$refs.title.focus();
            }
        }
    }
</script>

<style lang="scss" scoped>

</style>