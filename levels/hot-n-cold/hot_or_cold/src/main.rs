use std::env;
use std::path::{Path, Component};

const ALPHABET: &[&str] = &[
    "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
    "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"
];

fn main() {
    let cwd = env::var("PWD")
        .expect("could not get the PWD environment variable");
    let cwd = Path::new(&cwd);

    let mut parts: Vec<_> = cwd.components().rev().take(3).filter_map(|c| {
        match c {
            Component::Normal(path) => path.to_str(),
            _ => None
        }
    }).filter(|s| s.len() == 1).collect();
    parts.reverse();

    let secret = include_str!("../secret");
    let secret: Vec<usize> = secret.trim().split("\n").map(|c| {
        c.parse().unwrap()
    }).collect();

    let score =
        if parts.len() > 0 && parts[0] == ALPHABET[secret[0]] { 1 } else { 0 } +
        if parts.len() > 1 && parts[1] == ALPHABET[secret[1]] { 1 } else { 0 } +
        if parts.len() > 2 && parts[2] == ALPHABET[secret[2]] { 1 } else { 0 };

    println!("{}", match score {
        0 => "Freezing!",
        1 => "Chill",
        2 => "Toasty",
        3 => "On Fire!",
        _ => unreachable!()
    });

    if score == 3 {
        println!("Congratulations! You Found a Flag!");
        println!(" {} ", flag(parts));
    }
}

fn flag(parts: Vec<&str>) -> String {
    let encrypted = include_str!("../flag.enc").trim();
    let mut flag = String::new();
    for (a, b) in parts.iter().cycle().zip(encrypted.split("\n")) {
        let a: u8 = a.chars().next().unwrap() as u8;
        let b: u8 = b.parse().unwrap();
        let out: char = (a ^ b).into();
        flag.push(out);
    }
    flag
}
