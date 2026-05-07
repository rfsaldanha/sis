(function () {
  function setupPodcast(player) {
    const audio = player.querySelector(".podcast-audio");
    const transcriptNode = player.querySelector(".podcast-transcript");
    const transcriptUrl = player.dataset.transcript;

    if (!audio || !transcriptNode || !transcriptUrl) return;

    fetch(transcriptUrl)
      .then((response) => response.json())
      .then((segments) => {
        const buttons = segments.map((segment, index) => {
          const button = document.createElement("button");
          button.type = "button";
          const speakerClass = segment.speaker.toLowerCase();
          button.className = `podcast-line podcast-line-${speakerClass}`;
          button.dataset.index = index;
          button.dataset.start = segment.start;
          button.setAttribute("aria-label", `${segment.speaker}: ${segment.text}`);

          const text = document.createElement("span");
          text.className = "podcast-text";
          text.textContent = segment.text;

          button.appendChild(text);
          button.addEventListener("click", () => {
            audio.currentTime = segment.start;
            audio.play();
          });

          transcriptNode.appendChild(button);
          return button;
        });

        let activeIndex = -1;

        function setActive(index) {
          if (index === activeIndex) return;
          if (activeIndex >= 0) {
            buttons[activeIndex].classList.remove("is-active");
          }
          activeIndex = index;
          if (activeIndex >= 0) {
            const active = buttons[activeIndex];
            active.classList.add("is-active");
            active.scrollIntoView({ block: "nearest", behavior: "smooth" });
          }
        }

        function syncTranscript() {
          const time = audio.currentTime;
          const index = segments.findIndex((segment, i) => {
            const next = segments[i + 1];
            const end = next ? next.start : segment.end;
            return time >= segment.start && time < end;
          });
          setActive(index);
        }

        audio.addEventListener("timeupdate", syncTranscript);
        audio.addEventListener("seeked", syncTranscript);
        syncTranscript();
      })
      .catch(() => {
        transcriptNode.textContent = "Não foi possível carregar a transcrição sincronizada.";
      });
  }

  document.querySelectorAll(".podcast-player").forEach(setupPodcast);
})();
