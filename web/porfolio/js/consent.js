const shouldShowPopup = () => !storageType.getItem(consentPropertyName)
const saveToStorage = () => storageType.setItem(consentPropertyName, true)


window.onload = () => {

    const consentPopper = document.getElementById("consent-popup");
    const acceptBtn = document.getElementById('accept');

    const acceptFn = event => {
        saveToStorage()
        consentPopper.classList.add('hidden')
    }

    acceptBtn.addEventListener('click', acceptFn)

    if (shouldShowPopup()) {
        setTimeout(() => {
            consentPopper.classList.remove('hidden')
        }, 500)



    }
}
