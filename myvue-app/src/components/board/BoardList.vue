<template>
<div class="container">
    <link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!--여기에 글쓰기 폼 컴포넌트 삽입-->
    <div class="row">
        <div class="col-md-12 p-4 text-info">Loading Board...</div>        
        <div  class="col-md-12 p-4" style="height:600px;overflow-y:auto">        
            <ul class="media-list p-3" style="border:1px solid silver">
                <li class="media m-2 p-2" style="border-bottom:1px solid silver;background:#e9ecef"
                    v-for="(item, index) in boards" :key="index">
                    <a class="pull-left mr-5" href="#"> {{item.filename}}
                        <img  v-if="item.filename == 'moimage.png'"
                        src="http://pingendo.github.io/pingendo-bootstrap/assets/user_placeholder.png"
                        height="64" width="64" class="media-object center-block img-circle img-responsive">

                        <img v-else :src="item.imagePath" height="64" width="64" class="media-object center-block img-circle img-responsive">
                        <br>
                        <span>{{item.name}}</span>
                    </a>
                    <div class="media-body text-left">
                        <h4 class="media-heading">{{item.subject}}</h4>
                        <p>{{item.content}}</p>
                        <span class="badge badge-success">{{item.wdate}}</span>
                        <span><a><i class="fa fa-1x fa-fw fa-heart"></i></a></span>
                        <span><a><i class="fa fa-1x fa-fw fa-hand-o-down"></i></a></span>
                        <span><a><i class="fa fa-1x fa-fw fa-edit"></i></a></span>
                        <span><a><i class="fa fa-1x fa-fw fa-trash-o"></i></a></span>
                    </div>
                </li>              
            </ul>
        </div> 
    </div>
</div>
</template>

<script>
    import axios from 'axios'
    import eventBus from '@/eventBus'

    export default {
        created () {
            //게시글 목록을 서버에서 받아오기
            this.getBoardData();
            eventBus.$on('write-ok', function () {
                this.getBoardData();
            }.bind(this))
        },
        methods: {
            getBoardData () {
                //boardList.json 으로 요청 보내기 get() 함수 활용
                //응답 데이터 받아서 this.boards에 전달
                //v-for를 이용하여 게시 목록에 subject, content, name 출력하기
                //var url = 'http://localhost:9090/boardList.jsp';
                var url = '/boardList.jsp';
                axios.get(url)
                    .then((res)=>{
                        if (res.data.boards) {
                            this.boards = res.data.boards
                        }
                    })
                    .catch((err)=>{
                        console.log(err)
                    })
            }
        },
        data () {
            return {
                boards: [],
                loading: false,
            }
        }
    }
</script>

<style lang="scss" scoped>

</style>