$(document).ready(function() {
  if ($('#xtable').length > 0) {
    var mTable = document.getElementById('xtable')
        ,mTHead = mTable.querySelector('thead')
        ,amTh = mTHead.querySelectorAll('th')
        ,mTBody = mTable.querySelector('tbody')
    ;
    mTHead.addEventListener('click',function(e){
        var mTarget = e.target
            ,sTarget = mTarget.textContent
            ,mTh,iIndex,bAsc,sOrder
        ;

        mTh = mTarget;
        while (mTh.nodeName!=='TH') mTh = mTh.parentNode;
        iIndex = Array.prototype.indexOf.call(amTh,mTh);
        bAsc = mTh.getAttribute('data-order')==='asc';
        sOrder = bAsc?'desc':'asc';
        mTh.setAttribute('data-order',sOrder);
        tinysort(
            mTBody.querySelectorAll('tr')
            ,{
                selector:'td:nth-child('+(iIndex+1)+')'
                ,order: sOrder
            }
        );

    });
  }
})