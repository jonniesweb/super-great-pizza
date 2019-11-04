import ApolloClient from 'apollo-boost';
import { InMemoryCache } from 'apollo-cache-inmemory';

export const client = new ApolloClient({
  uri: '/graphql',
  headers: {
    'X-CSRF-Token': document.querySelector('meta[name=csrf-token]').getAttribute('content'),
  },
  credentials: 'same-origin',
  cache: new InMemoryCache(),
});
