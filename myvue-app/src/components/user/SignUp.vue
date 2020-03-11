<template>
    <div>
        <template v-if="isProcess">
            <div class="alert alert-danger"><h3>회원 가입 처리중...</h3></div>
        </template>
        <template v-else>
            <div id="join" class="container p-3">
                <h1 class="text-center">SingUp</h1>
                <form name="frm" action="join.jsp" @submit.prevent="submit">
                    <div class="row">    
                        <div class="col-md-8 offset-md-2">
                        Name: <input type="text" v-model="user.name" name="name"
                        placeholder="Name" class="form-control" >
                        </div>
                    </div>
                    
                    <div class="row">    
                        <div class="col-md-8 offset-md-2">
                        User ID: <input type="text" v-model="user.id" @keyup="checkId" name="id"  class="form-control" placeholder="User ID">
                        <div class="text-danger" v-show="idErr">아이디는 4자이상 6자 이하 입니다.</div>
                    </div>
                    </div>
                    <div class="row"> 
                        <div class="col-md-8 offset-md-2">
                            PASSWORD: <input type="text" v-model="user.pwd" @keyup="checkPwd" name="pwd" 
                            placeholder="Password" class="form-control">
                            <div class="text-danger" v-show="pwdErr">비밀번호는 4자 이상 8자 이내입니다.</div>
                        </div>
                    </div>
                    <div class="row"> 
                        <div class="col-md-8 offset-md-2">
                                PASSWORD Confirm :
                            <input type="text" v-model="user.pwd2" name="pwd2" @keyup="checkPwd2" placeholder="Password Confirm" class="form-control">    
                            <div class="text-danger" v-show="pwdErr2">비밀번호가 일치하지 않아요</div>
                        </div>       
                    </div> 
                    <div class="row"> 
                            <div class="col-md-8 offset-md-2">
                                    Email :
                                <input type="text" v-model="user.email" name="email" placeholder="Email" class="form-control">    
                            </div>       
                        </div> 
                
                    <div class="row  m-2">
                            <div class="col-md-8 offset-md-2 p-1">
                                <button class="btn btn-block btn-outline-success">Signup</buttoN>
                            </div>
                    </div>
                
                </form>
            </div>    
        </template>
    </div>
</template>

<script>
import axios from 'axios'

    export default {
        data () {
            return {
                user: {
                    name: '',
                    id: '',
                    pwd: '',
                    pwd2: '',
                    email: ''
                },
                idErr: false,
                pwdErr: false,
                pwdErr2: false,
                isProcess: false
            }
        },
        methods: {
            checkId () {
                var len = this.user.id.length;
                if (len < 4 || len > 6) {
                    this.idErr = true;
                } else {
                    this.idErr = false;
                }
            },
            checkPwd () {
                var len = this.user.pwd.length;
                this.pwdErr = (len <4 || len > 8) ? true : false;
            },
            checkPwd2 () {
                if (this.user.pwd === this.user.pwd2) {
                    this.pwdErr2 = false;
                } else {
                    this.pwdErr2 = true;
                }
            },
            submit () {
                if (!this.idErr && !this.pwdErr && !this.pwdErr2) {
                    this.isProcess = true;
                    //alert('회원가입 요청 중...');
                    //axios로 서버에 비동기 요청 예정.

                    /* 파라미터 데이터를 서버에 보낼 때
                    URLSearchParams 객체를 사용하자 */
                    var params = new URLSearchParams();
                    params.append('name', this.user.name);
                    params.append('id', this.user.id);
                    params.append('pwd', this.user.pwd);
                    params.append('email', this.user.email);

                    var vm = this;
                    //'userAdd.json'
                    var url = 'http://localhost:9090/signup.jsp'
                    axios.post(url, params)
                            .then(function(res){
                                //alert('seccess: ' + JSON.stringify(res))
                                if (res.data.result > 0) {
                                    alert('회원가입 처리 성공')
                                    vm.isProcess = false;
                                    vm.$router.push('/');
                                }
                            })
                            //}.bind(this))
                            // 익명함수에 bind() 를 이용하여 this를 붙인다.
                            // 그러면 then 안에서 this 사용 가능
                            .catch(function(err){
                                //alert('error: ' + err)
                                alert('회원가입 실패 :' + err.message)
                                vm.isProcess = false;
                            })
                    /* 
                    로컬 스토리지에 'vue-user'로 방금 가입한 회원 정보 저장
                    Login.vue 에서 아이디, 비밀번호 입력한 값이
                    localStorage에 저장된 회원과 같으면
                    홈페이지로 이동시키고
                    그렇지않으면 alert('회원이 아니에요') 띄우세요.
                    */
                   //localStorage.setItem('vue-user', JSON.stringify(this.user));
                   //this.$router.push('/');
                }
            }
        }
    }
</script>

<style lang="scss" scoped>

</style>