abstract class AppStates {}

//intial state
class AppIntialState extends AppStates {}

// Get products state
class AppGetProductsLoadingState extends AppStates {}

class AppGetProductsSuccessState extends AppStates {}

class AppGetProductsErrorState extends AppStates {}

//add value to recent searches list state
class AddToRecentSearchesStates extends AppStates {}

class RemoveFromRecentSearchesStates extends AppStates {}
