use std::collections::HashSet;
use std::collections::VecDeque;
use std::fs::File;
use std::io::{self, BufRead};

#[derive(Hash, Eq, PartialEq, Debug, Clone, Copy)]
struct Position(i32, i32);

fn move_head(head_pos: &Position, direction: &str) -> Position {
    let mut position = Position(head_pos.0, head_pos.1);
    match direction {
        "L" => position.0 = head_pos.0 - 1,
        "R" => position.0 = head_pos.0 + 1,
        "U" => position.1 = head_pos.1 - 1,
        "D" => position.1 = head_pos.1 + 1,
        _ => unreachable!(),
    }
    position
}

fn move_tail(head_pos: &Position, tail_pos: &Position) -> Position {
    let mut position = Position(tail_pos.0, tail_pos.1);

    if head_pos.0 != position.0 {
        position.0 = if (head_pos.0 - position.0) >= 0 {
            position.0 + 1
        } else {
            position.0 - 1
        }
    }

    if head_pos.1 != position.1 {
        position.1 = if (head_pos.1 - position.1) >= 0 {
            position.1 + 1
        } else {
            position.1 - 1
        }
    }

    position
}

fn r#move(direction: &str, head_pos: &Position, tail_pos: &Position) -> (Position, Position) {
    let new_head_pos = move_head(head_pos, direction);

    let new_tail_pos =
        if (new_head_pos.0 - tail_pos.0).abs() > 1 || (new_head_pos.1 - tail_pos.1).abs() > 1 {
            move_tail(&new_head_pos, tail_pos)
        } else {
            *tail_pos
        };

    (new_head_pos, new_tail_pos)
}

fn apply_movements(
    visited_cells: &mut HashSet<Position>,
    movements: &mut VecDeque<(String, i32)>,
    head_pos: Position,
    tail_pos: Position,
) -> (Position, Position) {
    if movements.is_empty() {
        return (head_pos, tail_pos);
    }

    let (direction, distance) = movements.pop_front().unwrap();
    let (new_head_pos, new_tail_pos) =
        (0..distance).fold((head_pos, tail_pos), |(head_pos, tail_pos), _| {
            let (new_head_pos, new_tail_pos) = r#move(&direction, &head_pos, &tail_pos);
            visited_cells.insert(new_tail_pos);
            (new_head_pos, new_tail_pos)
        });

    apply_movements(visited_cells, movements, new_head_pos, new_tail_pos)
}

fn part_1(movements: &mut VecDeque<(String, i32)>) -> usize {
    let mut visited_cells = HashSet::from([Position(0, 0)]);
    let head_pos = Position(0, 0);
    let tail_pos = Position(0, 0);
    apply_movements(&mut visited_cells, movements, head_pos, tail_pos);
    visited_cells.len()
}

fn part_2(movements: &VecDeque<(String, i32)>) -> i32 {
    todo!();
}

fn main() {
    match File::open("../input.txt") {
        Ok(file) => {
            let lines = io::BufReader::new(file).lines().flatten();
            let mut movements: VecDeque<(String, i32)> = lines
                .map(|line| {
                    let parts: Vec<&str> = line.split(" ").collect();
                    let direction = parts[0].to_string();
                    let distance = parts[1].parse::<i32>().unwrap();
                    (direction, distance)
                })
                .collect();

            dbg!(part_1(&mut movements));
            // part_2(&movements);
        }
        Err(e) => println!("{}", e),
    };
}
