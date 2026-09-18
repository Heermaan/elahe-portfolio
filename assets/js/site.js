// Lightbox: click any tile to view it full size. Esc / click outside closes. Arrow keys move.
(function () {
  var box = document.getElementById('lightbox');
  if (!box) return;
  var body = box.querySelector('.lightbox__body');
  var cap = box.querySelector('.lightbox__caption');
  var items = [], idx = 0;

  function collect(link) {
    var grid = link.closest('.grid');
    items = Array.prototype.slice.call(grid.querySelectorAll('[data-lightbox]'));
    idx = items.indexOf(link);
  }
  function show(i) {
    idx = (i + items.length) % items.length;
    var link = items[idx];
    body.innerHTML = '';
    var el;
    if (link.dataset.lightbox === 'video') {
      el = document.createElement('video');
      el.src = link.href; el.controls = true; el.autoplay = true; el.loop = true; el.playsInline = true;
    } else {
      el = document.createElement('img');
      el.src = link.href; el.alt = link.dataset.caption || '';
    }
    body.appendChild(el);
    cap.textContent = link.dataset.caption || '';
    box.hidden = false;
    document.body.style.overflow = 'hidden';
  }
  function close() {
    box.hidden = true; body.innerHTML = '';
    document.body.style.overflow = '';
  }

  document.addEventListener('click', function (e) {
    var link = e.target.closest('[data-lightbox]');
    if (link) { e.preventDefault(); collect(link); show(idx); return; }
    if (box.hidden) return;
    if (e.target.closest('.lightbox__close') || e.target === box) close();
    else if (e.target.closest('.lightbox__prev')) show(idx - 1);
    else if (e.target.closest('.lightbox__next')) show(idx + 1);
  });
  document.addEventListener('keydown', function (e) {
    if (box.hidden) return;
    if (e.key === 'Escape') close();
    else if (e.key === 'ArrowLeft') show(idx - 1);
    else if (e.key === 'ArrowRight') show(idx + 1);
  });
})();

// Home page header: transparent over the hero, solid once you scroll past it.
(function () {
  var header = document.querySelector('.is-home .site-header');
  var hero = document.querySelector('.hero');
  if (!header || !hero) return;
  function update() { header.classList.toggle('is-scrolled', window.scrollY > hero.offsetHeight - 80); }
  window.addEventListener('scroll', update, { passive: true });
  update();
})();

// Videos: show a poster image, load the player only when clicked.
document.addEventListener('click', function (e) {
  var btn = e.target.closest('.video-embed__play');
  if (!btn) return;
  var box = btn.closest('.video-embed');
  var f = document.createElement('iframe');
  f.src = box.dataset.src; f.title = box.dataset.title || 'Video';
  f.allow = 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; fullscreen';
  f.allowFullscreen = true;
  box.innerHTML = ''; box.appendChild(f);
});
