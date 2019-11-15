<iframe id="printFrame" style="display:none;"></iframe>
<script type="application/javascript">
    function silentPrint(url) {
        $("#printFrame").attr("src", url).load(function(){
            var that = this;
            setTimeout(function() {
                that.contentWindow.print();
            },100);
        });
    }
</script>