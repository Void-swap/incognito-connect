class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Welcome to the Incognito-Connect!",
    image: "assets/images/image1.jpg",
    desc: "Connect Safely and Share Freely",
  ),
  OnboardingContents(
    title: " Dive into Conversations!",
    image: "assets/images/image2.jpg",
    desc: " Engage Openly, Comfortably, and Anonymously",
  ),
  OnboardingContents(
    title: "Join the Supportive Chat Community!",
    image: "assets/images/image3.jpg",
    desc: "Share, Support, and Grow Together",
  ),
];
