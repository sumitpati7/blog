document.addEventListener("DOMContentLoaded", () => {
    const flashcards = document.querySelectorAll(".flashcard");
    flashcards.forEach(card => {
      card.addEventListener("click", () => {
        card.classList.toggle("flipped");
      });
    });
  });

  document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll("pre").forEach((pre) => {
        const button = document.createElement("button");
        button.innerHTML = `<i class="fa-solid fa-clone"></i>`
        button.className = "copy-button";

        // Position the button inside the pre block
        pre.style.position = "relative";
        pre.appendChild(button);

        button.addEventListener("click", async () => {
            const code = pre.querySelector("code").innerText;
            try {
                await navigator.clipboard.writeText(code);
                button.innerHTML = `<i class="fa-solid fa-check"></i>`;
                setTimeout(() => (button.innerHTML = `<i class="fa-solid fa-clone"></i>`), 2000);
            } catch (err) {
                console.error("Failed to copy: ", err);
            }
        });

        pre.addEventListener("mouseenter", () => {
          console.log('Check');
            button.style.opacity = 1;
        });

        pre.addEventListener("mouseleave", () => {
            button.style.opacity = 0;
        });
    });
});

  