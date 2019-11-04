import gql from 'graphql-tag';
import * as React from 'react';
import * as ApolloReactCommon from '@apollo/react-common';
import * as ApolloReactComponents from '@apollo/react-components';
import * as ApolloReactHoc from '@apollo/react-hoc';
import * as ApolloReactHooks from '@apollo/react-hooks';
export type Maybe<T> = T | null;
export type Omit<T, K extends keyof T> = Pick<T, Exclude<keyof T, K>>;
/** All built-in and custom scalars, mapped to their actual values */
export type Scalars = {
  ID: string,
  String: string,
  Boolean: boolean,
  Int: number,
  Float: number,
  /** An ISO 8601-encoded datetime */
  ISO8601DateTime: any,
};

export type Discount = {
   __typename?: 'Discount',
  code: Scalars['String'],
  createdAt: Scalars['ISO8601DateTime'],
  id: Scalars['ID'],
  imageUrl?: Maybe<Scalars['String']>,
  json: Scalars['String'],
  lastChecked: Scalars['ISO8601DateTime'],
  name: Scalars['String'],
  price?: Maybe<Scalars['String']>,
  productGroups: Array<ProductGroup>,
  removed: Scalars['Boolean'],
  store: Store,
  updatedAt: Scalars['ISO8601DateTime'],
};

export enum Group {
  Pizza = 'PIZZA',
  Wings = 'WINGS',
  Bread = 'BREAD',
  Drinks = 'DRINKS',
  Dessert = 'DESSERT',
  Feast = 'FEAST',
  None = 'NONE'
}


export type Product = {
   __typename?: 'Product',
  code: Scalars['String'],
  createdAt: Scalars['ISO8601DateTime'],
  name: Scalars['String'],
  productGroups: Array<ProductGroup>,
  updatedAt: Scalars['ISO8601DateTime'],
};

export type ProductGroup = {
   __typename?: 'ProductGroup',
  createdAt: Scalars['ISO8601DateTime'],
  discount: Discount,
  groupType: Group,
  maxQuantity: Scalars['Int'],
  products: Array<Product>,
  requiredQuantity: Scalars['Int'],
  updatedAt: Scalars['ISO8601DateTime'],
};

export type Query = {
   __typename?: 'Query',
  storeByCode?: Maybe<Store>,
  stores: Array<Store>,
};


export type QueryStoreByCodeArgs = {
  code: Scalars['String']
};

export type Store = {
   __typename?: 'Store',
  address?: Maybe<Scalars['String']>,
  city?: Maybe<Scalars['String']>,
  code: Scalars['String'],
  createdAt: Scalars['ISO8601DateTime'],
  discounts: Array<Discount>,
  json: Scalars['String'],
  updatedAt: Scalars['ISO8601DateTime'],
};

export type AllStoresQueryVariables = {};


export type AllStoresQuery = (
  { __typename?: 'Query' }
  & { stores: Array<(
    { __typename?: 'Store' }
    & Pick<Store, 'address' | 'code'>
  )> }
);

export type DiscountsForStoreQueryVariables = {
  storeId: Scalars['String']
};


export type DiscountsForStoreQuery = (
  { __typename?: 'Query' }
  & { storeByCode: Maybe<(
    { __typename?: 'Store' }
    & { discounts: Array<(
      { __typename?: 'Discount' }
      & Pick<Discount, 'id' | 'code' | 'price' | 'name'>
    )> }
  )> }
);


export const AllStoresDocument = gql`
    query AllStores {
  stores {
    address
    code
  }
}
    `;
export type AllStoresComponentProps = Omit<ApolloReactComponents.QueryComponentOptions<AllStoresQuery, AllStoresQueryVariables>, 'query'>;

    export const AllStoresComponent = (props: AllStoresComponentProps) => (
      <ApolloReactComponents.Query<AllStoresQuery, AllStoresQueryVariables> query={AllStoresDocument} {...props} />
    );
    
export type AllStoresProps<TChildProps = {}> = ApolloReactHoc.DataProps<AllStoresQuery, AllStoresQueryVariables> & TChildProps;
export function withAllStores<TProps, TChildProps = {}>(operationOptions?: ApolloReactHoc.OperationOption<
  TProps,
  AllStoresQuery,
  AllStoresQueryVariables,
  AllStoresProps<TChildProps>>) {
    return ApolloReactHoc.withQuery<TProps, AllStoresQuery, AllStoresQueryVariables, AllStoresProps<TChildProps>>(AllStoresDocument, {
      alias: 'allStores',
      ...operationOptions
    });
};

/**
 * __useAllStoresQuery__
 *
 * To run a query within a React component, call `useAllStoresQuery` and pass it any options that fit your needs.
 * When your component renders, `useAllStoresQuery` returns an object from Apollo Client that contains loading, error, and data properties 
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useAllStoresQuery({
 *   variables: {
 *   },
 * });
 */
export function useAllStoresQuery(baseOptions?: ApolloReactHooks.QueryHookOptions<AllStoresQuery, AllStoresQueryVariables>) {
        return ApolloReactHooks.useQuery<AllStoresQuery, AllStoresQueryVariables>(AllStoresDocument, baseOptions);
      }
export function useAllStoresLazyQuery(baseOptions?: ApolloReactHooks.LazyQueryHookOptions<AllStoresQuery, AllStoresQueryVariables>) {
          return ApolloReactHooks.useLazyQuery<AllStoresQuery, AllStoresQueryVariables>(AllStoresDocument, baseOptions);
        }
export type AllStoresQueryHookResult = ReturnType<typeof useAllStoresQuery>;
export type AllStoresLazyQueryHookResult = ReturnType<typeof useAllStoresLazyQuery>;
export type AllStoresQueryResult = ApolloReactCommon.QueryResult<AllStoresQuery, AllStoresQueryVariables>;
export const DiscountsForStoreDocument = gql`
    query DiscountsForStore($storeId: String!) {
  storeByCode(code: $storeId) {
    discounts {
      id
      code
      price
      name
    }
  }
}
    `;
export type DiscountsForStoreComponentProps = Omit<ApolloReactComponents.QueryComponentOptions<DiscountsForStoreQuery, DiscountsForStoreQueryVariables>, 'query'> & ({ variables: DiscountsForStoreQueryVariables; skip?: boolean; } | { skip: boolean; });

    export const DiscountsForStoreComponent = (props: DiscountsForStoreComponentProps) => (
      <ApolloReactComponents.Query<DiscountsForStoreQuery, DiscountsForStoreQueryVariables> query={DiscountsForStoreDocument} {...props} />
    );
    
export type DiscountsForStoreProps<TChildProps = {}> = ApolloReactHoc.DataProps<DiscountsForStoreQuery, DiscountsForStoreQueryVariables> & TChildProps;
export function withDiscountsForStore<TProps, TChildProps = {}>(operationOptions?: ApolloReactHoc.OperationOption<
  TProps,
  DiscountsForStoreQuery,
  DiscountsForStoreQueryVariables,
  DiscountsForStoreProps<TChildProps>>) {
    return ApolloReactHoc.withQuery<TProps, DiscountsForStoreQuery, DiscountsForStoreQueryVariables, DiscountsForStoreProps<TChildProps>>(DiscountsForStoreDocument, {
      alias: 'discountsForStore',
      ...operationOptions
    });
};

/**
 * __useDiscountsForStoreQuery__
 *
 * To run a query within a React component, call `useDiscountsForStoreQuery` and pass it any options that fit your needs.
 * When your component renders, `useDiscountsForStoreQuery` returns an object from Apollo Client that contains loading, error, and data properties 
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useDiscountsForStoreQuery({
 *   variables: {
 *      storeId: // value for 'storeId'
 *   },
 * });
 */
export function useDiscountsForStoreQuery(baseOptions?: ApolloReactHooks.QueryHookOptions<DiscountsForStoreQuery, DiscountsForStoreQueryVariables>) {
        return ApolloReactHooks.useQuery<DiscountsForStoreQuery, DiscountsForStoreQueryVariables>(DiscountsForStoreDocument, baseOptions);
      }
export function useDiscountsForStoreLazyQuery(baseOptions?: ApolloReactHooks.LazyQueryHookOptions<DiscountsForStoreQuery, DiscountsForStoreQueryVariables>) {
          return ApolloReactHooks.useLazyQuery<DiscountsForStoreQuery, DiscountsForStoreQueryVariables>(DiscountsForStoreDocument, baseOptions);
        }
export type DiscountsForStoreQueryHookResult = ReturnType<typeof useDiscountsForStoreQuery>;
export type DiscountsForStoreLazyQueryHookResult = ReturnType<typeof useDiscountsForStoreLazyQuery>;
export type DiscountsForStoreQueryResult = ApolloReactCommon.QueryResult<DiscountsForStoreQuery, DiscountsForStoreQueryVariables>;