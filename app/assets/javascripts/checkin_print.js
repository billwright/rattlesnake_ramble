(function () {
  function handleCheckinPrint(event) {
    event.preventDefault();

    var link = event.currentTarget;
    var url = link && link.getAttribute('href');
    if (!url) { return; }

    var existingFrame = document.getElementById('checkin-sheet-print-frame');
    if (existingFrame && existingFrame.parentNode) {
      existingFrame.parentNode.removeChild(existingFrame);
    }

    var iframe = document.createElement('iframe');
    iframe.id = 'checkin-sheet-print-frame';
    iframe.style.position = 'fixed';
    iframe.style.right = '0';
    iframe.style.bottom = '0';
    iframe.style.width = '0';
    iframe.style.height = '0';
    iframe.style.border = '0';
    iframe.style.visibility = 'hidden';

    iframe.addEventListener('load', function () {
      try {
        iframe.contentWindow.focus();
        iframe.contentWindow.print();
      } catch (error) {
        console.error('Check-in sheet print failed', error);
        window.location = url;
      }

      setTimeout(function () {
        if (iframe.parentNode) {
          iframe.parentNode.removeChild(iframe);
        }
      }, 1000);
    });

    iframe.addEventListener('error', function () {
      window.location = url;
    });

    iframe.src = url;
    document.body.appendChild(iframe);
  }

  function initializeCheckinPrint() {
    var links = document.querySelectorAll('[data-checkin-print]');
    Array.prototype.forEach.call(links, function (link) {
      if (link.dataset.checkinPrintBound === 'true') { return; }
      link.addEventListener('click', handleCheckinPrint);
      link.dataset.checkinPrintBound = 'true';
    });
  }

  document.addEventListener('turbolinks:load', initializeCheckinPrint);
})();
