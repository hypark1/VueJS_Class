<template>
    <div class="col-md-4 col-sm-12 col-xs-12 p-3">

        <div class="card"  style="height: 350px;overflow-y:auto">
        <ul class="list-group">
            <li class="list-group-item active d-flex justify-content-between align-items-center">
            Memo List
                <span class="badge badge-danger badge-pill">2020-01-01</span>
            </li>        
            <li class="list-group-item d-flex justify-content-between align-items-center"
            v-for="(item, index) in memoArr" :key="index">                   
                <a href="#" @click.prevent="showMemo(item)">{{item.title}}</a>
                <span class="badge badge-danger badge-pill">{{item.wdate}}</span>
            </li>         
        </ul>
        </div>                
    </div>
</template>

<script>
    import eventBus from '../../eventBus/index.js';

    export default {
        data () {
            return {}
        },
        props: [ 'memo-arr' ],
        methods: {
            showMemo (val) {
                //alert(val.title)
                eventBus.$emit('show-view', val);
            }
        }
    }
</script>

<style lang="scss" scoped>

</style>