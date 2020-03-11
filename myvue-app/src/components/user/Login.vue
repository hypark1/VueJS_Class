<template>
    <div class="col-md-3 mt-4">
        <h1 class="text-center">Login</h1>
        <template v-if="!isLogin">
            <form name="loginF" method="POST" @submit.prevent="loginCheck" >
                <div class="row">    
                    <div class="col-md-10 offset-md-1">
                        User ID: <input type="text" v-model="tmpUser.id" ref="uid" name="id" 
                        placeholder="User ID" class="form-control" >    
                    </div>
                </div>
                <div class="row"> 
                    <div class="col-md-10 offset-md-1">
                        PASSWORD: <input type="password" v-model="tmpUser.pwd" ref="upwd" name="pwd" 
                        placeholder="Password" class="form-control">    
                    </div>
                </div>
                <div class="col-md-10 offset-md-1 p-1">
                        <button class="btn btn-block btn-primary mt-3">Login</button>
                </div>        
            </form> 
        </template>
        <template v-else>
            <div class="alert alert-primary m-4">
                <h4>{{user.id}}님 로그인 중...</h4>
                <p @click="logout">로그아웃</p>
            </div>
        </template>
    </div>
</template>

<script>
import axios from 'axios'

    export default {
        data () {
            return {
                tmpUser: { //로그인 시도하는 사람의 id, pwd 담을 데이터
                    id: '',
                    pwd: ''
                },
                user: { // 로그인한 사람의 정보를 담을 데이터
                    idx: '',
                    name: '',
                    id: ''
                },
                isLogin: false
            }
        },
        methods: {
            loginCheck () {
                if (!this.tmpUser.id) {
                    alert('아이디를 입력하세요.');
                    this.$refs.uid.focus();
                    return;
                }
                if (!this.tmpUser.pwd) {
                    alert('비밀번호를 입력하세요.');
                    this.$refs.upwd.focus();
                    return;
                }
                this.requestLogin(); //서버에 로그인 데이터 전송하는 메소드
            },
            requestLogin () {
                var url = 'http://localhost:9090/loginCheck.jsp';
                //파라미터 데이터 만들기 id, pwd
                var params = new URLSearchParams();
                params.append('id', this.tmpUser.id);
                params.append('pwd', this.tmpUser.pwd);
                axios.post(url, params)
                        .then ((res)=>{
                            //console.log(res)
                            this.user = res.data.user;
                            if (!this.user.idx) {
                                //회원번호 데이터가 없다면 로그인 인증 실패
                                alert('아이디와 비밀번호를 확인하세요.');
                                this.isLogin = false;
                                this.tmpUser.id = '';
                                this.tmpUser.pwd = '';
                                this.$refs.uid.focus();
                            } else {
                                //로그인 인증을 받았다면..
                                alert('로그인 성공');
                                sessionStorage.setItem('uname', this.user.name);
                                sessionStorage.setItem('uidx', this.user.idx);
                                sessionStorage.setItem('uid', this.user.id);
                                this.isLogin = true;
                            }
                        })
                        .catch ((err)=>{
                            console.log(err);
                        })
            },
            logout () {
                //alert('로그아웃 처리 중');
                var url = "http://localhost:9090/logout.jsp"
                axios.get(url)
                        .then((res)=>{
                            if (res.status == 200) {
                                //서버쪽에서 로그아웃 처리를 마쳤다면
                                //세션스토리지 비우기
                                sessionStorage.clear();
                                this.isLogin = false;
                            }
                        })
                        .catch((err)=>{
                            console.log(err);
                        })
            },
            Login () {
                if (this.user.id && this.user.pwd) {
                    var data = JSON.parse(localStorage.getItem('vue-user'));
                    if (this.user.id === data.id && this.user.pwd === data.pwd) {
                        alert('로그인 성공');
                    } else {
                        alert('회원이 아닙니다.')
                    }
                }
            }
        }
    }
</script>

<style lang="scss" scoped>

</style>