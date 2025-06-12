document.addEventListener("DOMContentLoaded", function () {
  var sidenav = document.querySelector("aside");
  var sidenav_trigger = document.querySelector("[sidenav-trigger]");
  var sidenav_close_button = document.querySelector("[sidenav-close]");

  if (!sidenav || !sidenav_trigger) return;

  sidenav_trigger.addEventListener("click", function () {
    const isOpen = sidenav.classList.contains("translate-x-0");

    sidenav.classList.toggle("translate-x-0", !isOpen);
    sidenav.classList.toggle("-translate-x-full", isOpen);
    sidenav.setAttribute("aria-expanded", !isOpen ? "true" : "false");
  });

  if (sidenav_close_button) {
    sidenav_close_button.addEventListener("click", function () {
      sidenav.classList.remove("translate-x-0");
      sidenav.classList.add("-translate-x-full");
      sidenav.setAttribute("aria-expanded", "false");
    });
  }

  // Close when clicking outside (on mobile)
  window.addEventListener("click", function (e) {
    if (!sidenav.contains(e.target) && !sidenav_trigger.contains(e.target)) {
      if (sidenav.classList.contains("translate-x-0")) {
        sidenav.classList.remove("translate-x-0");
        sidenav.classList.add("-translate-x-full");
        sidenav.setAttribute("aria-expanded", "false");
      }
    }
  });
});
