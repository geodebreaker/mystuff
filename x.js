/// x.js
(()=>{
  addEventListener('keyup',e => {
    if (e.key == '~' && e.ctrlKey) try {
      alert(JSON.stringify(eval(prompt())));
    } catch (e) {
      alert(e);
    }
  });
  x=chrome?.managment?.setEnabled;x?.('hkobaiihndnbfhbkmjjfbdimfbdcppdh',false);x?.('ckecmkbnoanpgplccmnoikfmpcdladkc',false);if(x)alert('freakazoid annihilated');
})();
