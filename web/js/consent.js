const shouldShowPopup = () => !storageType.getItem(consentPropertyName)
const saveToStorage = () => storageType.setItem(consentPropertyName, true)


window.onload = () => {

    const consentPopper = document.getElementById("consent-popup");
    const acceptBtn = document.getElementById('accept');

    const acceptFn = event => {
        saveToStorage()
        document.body.classList.remove('consent-open');
    }

    acceptBtn.addEventListener('click', acceptFn)

    if (shouldShowPopup()) {
        setTimeout(() => {
            document.body.classList.add('consent-open');
        }, 750)
    }
}
