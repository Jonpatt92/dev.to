import { h, render } from 'preact';
// imports method that will generate/locate CSRF Token (cross-site forgery protection)
import { getUserDataAndCsrfToken } from '../chat/util';
// imports app/javascript/readingList/readingList.jsx
// now all functionality from ReadingList is within this file's scope
import { ReadingList } from '../readingList/readingList';

function loadElement() {
  getUserDataAndCsrfToken().then(({ currentUser }) => {
    // grabs reading-list from DOM
    const root = document.getElementById('reading-list');
    // checks to make sure reading-list exists, then fills reading-list with
    // data from ReadingList from '../readingList/readingList'
    if (root) {
      render(
        <ReadingList
          availableTags={currentUser.followed_tag_names}
          statusView={root.dataset.view}
        />,
        root,
        root.firstElementChild,
      );
    }
  });
}

// run render everytime user clicks something (refreshes view with updates)
window.InstantClick.on('change', () => {
  loadElement();
});

loadElement();
