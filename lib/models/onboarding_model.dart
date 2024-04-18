class OnboardingModel {
  final String title;
  final String image;
  final String subTitle;

  OnboardingModel({
    required this.title,
    required this.image,
    required this.subTitle,
  });

    static List<OnboardingModel> onboardingList = [
    OnboardingModel(
      title: 'Manage your task',
      image: 'https://www.exudeinc.com/wp-content/uploads/2018/04/onboarding.jpg',
      subTitle: 'you can easily manage your task',
    ),OnboardingModel(
      title: 'Create daily routine',
      image: 'https://www.polly.ai/hubfs/Blog/Featured%20Images%20%28png%29/Employee%20Onboarding%203.png',
      subTitle: 'you can easily create your daily routine',
    ),OnboardingModel(
      title: 'Get started',
      image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQos6SHkZ5dG9KosH9HYIYHit73vxGrnRfShg&s',
      subTitle: 'Get started to organize your tasks',
    ),
  ];
}
