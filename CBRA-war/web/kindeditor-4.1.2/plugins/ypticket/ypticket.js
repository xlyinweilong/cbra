/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
KindEditor.plugin('ypticket', function(K) {
        var editor = this, name = 'ypticket';
        // 点击图标时执行
        editor.clickToolbar(name, function() {
                //alert("Add Ticket!");
                editor.insertHtml('<img src="/images/yoopay_ticket.png"/>');
        });
});

