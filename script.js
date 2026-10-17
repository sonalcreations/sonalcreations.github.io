// Reveal sections as they enter the viewport. Falls back to visible if the
// observer is missing or the visitor prefers reduced motion.
const reduce = matchMedia('(prefers-reduced-motion: reduce)').matches;
const targets = document.querySelectorAll('.reveal');
if (!reduce && 'IntersectionObserver' in window) {
  const io = new IntersectionObserver((entries) => {
    for (const e of entries) {
      if (e.isIntersecting) { e.target.classList.add('is-in'); io.unobserve(e.target); }
    }
  }, { rootMargin: '0px 0px -10% 0px', threshold: 0.15 });
  targets.forEach((t) => io.observe(t));
} else {
  targets.forEach((t) => t.classList.add('is-in'));
}

document.getElementById('year').textContent = new Date().getFullYear();
