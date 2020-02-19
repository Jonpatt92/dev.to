import { h, render } from 'preact';
import { Article, Feed, LoadingArticle } from '../articles';
import { FeaturedArticle } from '../articles/FeaturedArticle';

export const renderFeed = () => {
  const feedContainer = document.getElementById('homepage-feed');

  render(
    <Feed
      renderFeedItems={(feedItems = []) => {
        if (feedItems.length === 0) {
          // Fancy loading ✨
          return (
            <div>
              <LoadingArticle />
              <LoadingArticle />
              <LoadingArticle />
            </div>
          );
        }

        const [featuredStory, ...subStories] = feedItems.map(item => ({
          ...item,
          user: item.user.table,
          organization: item.organization ? item.organization.table : null,
        }));

        // 1. Show the featured story first
        // 2. Podcast episodes out today
        // 3. Rest of the stories for the feed

        // TODO: Featured
        return (
          <div>
            <FeaturedArticle article={featuredStory} />
            <div id="article-index-podcast-div">PODCAST EPISODES</div>
            {(subStories || []).map(story => (
              <Article article={story} />
            ))}
          </div>
        );
      }}
    />,
    feedContainer,
    feedContainer.firstElementChild,
  );
};